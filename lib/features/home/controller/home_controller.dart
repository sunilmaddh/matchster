import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/home/models/habit_option.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/home/models/like_response.dart';
import 'package:matchster/features/home/models/requests/create_interaction_request.dart';
import 'package:matchster/features/home/models/requests/get_profile_request.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';

class HomeController extends BaseController {
  HomeController({required this.homeRepository});

  final HomeRepository homeRepository;

  late final PageController pageController;
  final CardSwiperController swiperController = CardSwiperController();
  final ScrollController scrollController = ScrollController();

  final RxList<Profile> profileList = <Profile>[].obs;
  final RxList<Profile> remainingProfiles = <Profile>[].obs;
  final RxList<Datum> likeList = <Datum>[].obs;
  final RxList<String> inShortTextList = <String>[].obs;
  final RxList<InshortList> inShortItems = <InshortList>[].obs;

  final RxBool showLike = false.obs;
  final RxBool isGettingProfile = false.obs;
  final RxBool isOverlay = false.obs;
  final RxBool isLike = false.obs;
  final RxBool isFetchingMore = false.obs;
  final RxBool showUpArrow = true.obs;

  final RxInt selectedIndex = 0.obs;
  final RxInt currentProfileIndex = 0.obs;
  final RxInt currentIndex = 0.obs;

  double _lastOffset = 0.0;

  static const int _defaultFilterCount = 10;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
    scrollController.addListener(_onScroll);
    fetchInitialProfiles();
  }

  Profile? get currentProfile {
    if (profileList.isEmpty) return null;
    if (currentProfileIndex.value < 0 ||
        currentProfileIndex.value >= profileList.length) {
      return null;
    }
    return profileList[currentProfileIndex.value];
  }

  Future<void> fetchInitialProfiles() async {
    if (profileList.isNotEmpty) return;

    await getProfileList(
      filterType: AppStrings.basic,
      filter: _defaultFilterCount,
    );
  }

  void onTabTapped(int index) {
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void _onScroll() {
    final currentOffset = scrollController.offset;

    if (currentOffset > _lastOffset && !showUpArrow.value) {
      showUpArrow.value = true;
    } else if (currentOffset < _lastOffset && showUpArrow.value) {
      showUpArrow.value = false;
    }

    _lastOffset = currentOffset;
  }

  void onVerticalDrag(double dy) {
    if (!scrollController.hasClients) return;

    final targetOffset = (scrollController.offset - dy).clamp(
      0.0,
      scrollController.position.maxScrollExtent,
    );

    scrollController.jumpTo(targetOffset);
  }

  Future<void> getProfileList({
    required String filterType,
    required int filter,
  }) async {
    try {
      isGettingProfile.value = true;
      final request = GetProfileRequest(
        filterType: filterType,
        distance: filter,
      );

      final response = await homeRepository.getProfileList(request: request);

      final profiles = response.data?.profiles ?? [];

      profileList.clear();
      remainingProfiles.clear();

      if (response.success && profiles.isNotEmpty) {
        profileList.assignAll(profiles);
        remainingProfiles.assignAll(profiles);
        currentProfileIndex.value = 0;
        _updateInShortData();
      } else {
        _clearProfileState();
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    } finally {
      isGettingProfile.value = false;
    }
  }

  Future<void> createInterection({
    required String userId,
    required String action,
  }) async {
    final request = CreateInteractionRequest(userId: userId, action: action);
    try {
      final response = await homeRepository.createInterection(request: request);

      if (!response.success) {
        AppMethods.appPrint(message: response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> likeOnMe() async {
    try {
      final response = await homeRepository.likeOnMe();

      if (response.success && response.data != null) {
        likeList.assignAll(response.data!.data);
      } else {
        AppToastMessage.show(
          title: AppStrings.error,
          message: response.message,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  bool onSwipe(
    int previousIndex,
    int? newIndex,
    CardSwiperDirection direction,
  ) {
    if (!_isValidSwipe(previousIndex: previousIndex, newIndex: newIndex)) {
      return true;
    }

    final profile = profileList[previousIndex];
    final action =
        direction == CardSwiperDirection.right
            ? AppStrings.like
            : AppStrings.dislike;

    if (direction == CardSwiperDirection.right) {
      _showLikeAnimation();
    }

    final userId = profile.userId;
    if (userId != null && userId.isNotEmpty) {
      createInterection(userId: userId, action: action);
    }

    currentProfileIndex.value = newIndex!;
    _removeFirstRemainingProfile();
    _updateInShortData();

    if (remainingProfiles.isEmpty) {
      _loadMoreProfilesIfNeeded();
    }

    return true;
  }

  void handleInteraction({required bool isLikeAction}) {
    if (profileList.isEmpty) return;

    isLike.value = isLikeAction;
    isOverlay.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isOverlay.value = false;
      isLike.value = false;

      swiperController.swipe(
        isLikeAction ? CardSwiperDirection.right : CardSwiperDirection.left,
      );
    });
  }

  void onLikeTap() {
    handleInteraction(isLikeAction: true);
  }

  void onDislikeTap() {
    handleInteraction(isLikeAction: false);
  }

  Future<void> preloadInitialCachedImages(List<Profile> profiles) async {
    final preloadCount = profiles.length < 3 ? profiles.length : 3;

    for (int i = 0; i < preloadCount; i++) {
      final imageUrl = profiles[i].mainPhoto;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        CachedNetworkImageProvider(
          imageUrl,
        ).resolve(const ImageConfiguration());
      }
    }
  }

  Future<void> preloadInitialCards(
    BuildContext context,
    List<Profile> profiles,
  ) async {
    final preloadCount = profiles.length < 3 ? profiles.length : 3;

    for (int i = 0; i < preloadCount; i++) {
      final imageUrl = profiles[i].mainPhoto;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await precacheImage(CachedNetworkImageProvider(imageUrl), context);
      }
    }
  }

  List<HabitOption> buildHabitOptions(
    HabitTypeEnum type, {
    Set<FrequencyEnum>? exclude,
  }) {
    return FrequencyEnum.values
        .where((frequency) => exclude == null || !exclude.contains(frequency))
        .map((frequency) => HabitOption(type: type, frequency: frequency))
        .toList();
  }

  void _clearProfileState() {
    profileList.clear();
    remainingProfiles.clear();
    inShortItems.clear();
    inShortTextList.clear();
    currentProfileIndex.value = 0;
  }

  bool _isValidSwipe({required int previousIndex, required int? newIndex}) {
    if (newIndex == null) return false;
    if (profileList.isEmpty) return false;
    if (previousIndex < 0 || previousIndex >= profileList.length) {
      return false;
    }
    return true;
  }

  void _removeFirstRemainingProfile() {
    if (remainingProfiles.isNotEmpty) {
      remainingProfiles.removeAt(0);
    }
  }

  Future<void> _loadMoreProfilesIfNeeded() async {
    if (isFetchingMore.value) return;

    try {
      isFetchingMore.value = true;
      await getProfileList(
        filterType: AppStrings.basic,
        filter: _defaultFilterCount,
      );
    } finally {
      isFetchingMore.value = false;
    }
  }

  void _showLikeAnimation() {
    showLike.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      showLike.value = false;
    });
  }

  void _updateInShortData() {
    final profile = currentProfile;

    if (profile == null) {
      inShortItems.clear();
      inShortTextList.clear();
      return;
    }

    final List<InshortList> items = [];

    _addGender(profile, items);
    _addSmoking(profile, items);
    _addDrinking(profile, items);
    _addReligion(profile, items);
    _addZodiac(profile, items);
    _addHeight(profile, items);

    inShortItems.assignAll(items);

    inShortTextList.assignAll(
      [
            profile.gender,
            profile.smoking,
            profile.drinking,
            profile.religion,
            profile.zodiacSign,
            profile.height,
          ]
          .where((value) => value != null && value.toString().trim().isNotEmpty)
          .cast<String>()
          .toList(),
    );
  }

  void _addGender(Profile profile, List<InshortList> items) {
    final value = profile.gender;
    if (value == null || value.trim().isEmpty) return;

    final gender = GenderEnumX.fromApi(value);
    if (gender != null) {
      items.add(InshortList(text: value, img: gender.emoji));
    }
  }

  void _addSmoking(Profile profile, List<InshortList> items) {
    final value = profile.smoking;
    if (value == null || value.trim().isEmpty) return;

    final frequency = frequencyFromApi(value);
    if (frequency != null) {
      final option = HabitOption(
        type: HabitTypeEnum.smoke,
        frequency: frequency,
      );
      items.add(InshortList(text: option.label, img: option.emoji));
    }
  }

  void _addDrinking(Profile profile, List<InshortList> items) {
    final value = profile.drinking;
    if (value == null || value.trim().isEmpty) return;

    final frequency = frequencyFromApi(value);
    if (frequency != null) {
      final option = HabitOption(
        type: HabitTypeEnum.drinking,
        frequency: frequency,
      );
      items.add(InshortList(text: option.label, img: option.emoji));
    }
  }

  void _addReligion(Profile profile, List<InshortList> items) {
    final value = profile.religion;
    if (value == null || value.trim().isEmpty) return;

    final religion = ReligionEnumX.fromApi(value);
    if (religion != null) {
      items.add(InshortList(text: religion.label, img: religion.emoji));
    }
  }

  void _addZodiac(Profile profile, List<InshortList> items) {
    final value = profile.zodiacSign;
    if (value == null || value.trim().isEmpty) return;

    final zodiac = ZodiacEnumX.fromApi(value);
    if (zodiac != null) {
      items.add(InshortList(text: zodiac.label, img: zodiac.emoji));
    }
  }

  void _addHeight(Profile profile, List<InshortList> items) {
    final value = profile.height;
    if (value == null || value.trim().isEmpty) return;

    final height = HeightEnumExt.fromApi(value);
    if (height != null) {
      items.add(InshortList(text: value, img: height.emoji));
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    pageController.dispose();
    swiperController.dispose();
    super.onClose();
  }
}

FrequencyEnum? frequencyFromApi(String value) {
  for (final frequency in FrequencyEnum.values) {
    if (frequency.name.toLowerCase() == value.toLowerCase()) {
      return frequency;
    }
  }
  return null;
}
