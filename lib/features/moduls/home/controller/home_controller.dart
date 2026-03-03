import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/moduls/home/models/habit_option.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/models/inshort_list.dart';
import 'package:matchster/features/moduls/home/models/like_response.dart';
import 'package:matchster/features/moduls/home/services/home_services.dart';

class HomeController extends GetxController {
  /* ----------------------------------------------------
   * CONTROLLERS
   * -------------------------------------------------- */

  PageController pageController = PageController();
  final CardSwiperController swiperController = CardSwiperController();

  /* ----------------------------------------------------
   * STATE
   * -------------------------------------------------- */

  final RxList<Profile> profileList = <Profile>[].obs;
  final RxList<Profile> profileListCount = <Profile>[].obs;
  final RxList<Datum> likeList = <Datum>[].obs;
  final RxList<String> inShortList = <String>[].obs;
  RxBool showLike = false.obs;

  final RxInt selectedIndex = 0.obs;
  final RxInt currentIndex = 0.obs;

  final RxBool isGettingProfile = false.obs;
  final RxBool isOverlay = false.obs;
  final RxBool isLike = false.obs;
  final RxMap<String, dynamic> singleMap = <String, dynamic>{}.obs;

  final HomeServices _homeService = HomeServices();
  RxList<InshortList> inshortList = <InshortList>[].obs;
  RxBool isFetchingMore = false.obs;

  /* ----------------------------------------------------
   * GETTERS (SAFE)
   * -------------------------------------------------- */

  Profile? get currentProfile {
    if (profileList.isEmpty) return null;
    if (currentIndex.value < 0 || currentIndex.value >= profileList.length) {
      return null;
    }
    return profileList[currentIndex.value];
  }

  /* ----------------------------------------------------
   * BOTTOM TAB
   * -------------------------------------------------- */

  void onTabTapped(int index) {
    selectedIndex.value = index;
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  /* ----------------------------------------------------
   * PROFILE LIST
   * -------------------------------------------------- */

  Future<void> getProfileList({
    required String filterType,
    required int filter,
  }) async {
    try {
      isGettingProfile.value = true;

      final response = await _homeService.getProfileLisr(
        filterType: filterType,
        filter: filter,
      );
      profileList.clear();
      profileListCount.clear();
      if (response.success && response.data?.profiles != null) {
        profileList.assignAll(response.data!.profiles!);
        profileListCount.assignAll(response.data!.profiles!);
        
        // Preload first 3 images
        for (int i = 0; i < 3 && i < profileList.length; i++) {
          if (profileList[i].mainPhoto != null && profileList[i].mainPhoto!.isNotEmpty) {
            CachedNetworkImageProvider(profileList[i].mainPhoto!)
                .resolve(const ImageConfiguration());
          }
        }

        currentIndex.value = 0;
        await _updateInShort();

        isGettingProfile.value = false;
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    } finally {}
  }

  /* ----------------------------------------------------
   * CREATE INTERACTION
   * -------------------------------------------------- */

  Future<void> createInterection({
    required String userId,
    required String action,
  }) async {
    try {
      final response = await _homeService.createInterection(
        userId: userId,
        action: action,
      );

      if (!response.success) {
        AppMethods.appPrint(message: response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  /* ----------------------------------------------------
   * LIKE ON ME
   * -------------------------------------------------- */

  Future<void> likeOnMe() async {
    try {
      final response = await _homeService.likeOnMe();

      if (response.success && response.data != null) {
        likeList.assignAll(response.data!.data);
      } else {
        AppToastMessage.show(title: "Error", message: response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  /* ----------------------------------------------------
   * CARD SWIPE
   * -------------------------------------------------- */

  bool onSwipe(
    int previousIndex,
    int? newIndex,
    CardSwiperDirection direction,
  ) {
    /// Safety checks
    if (newIndex == null) return true;
    if (profileList.isEmpty) return true;
    if (previousIndex < 0 || previousIndex >= profileList.length) {
      return true;
    }

    if (direction == CardSwiperDirection.right) {
      playLike();
    }

    final swipedProfile = profileList[previousIndex];

    /// 🔥 Call API
    createInterection(
      userId: swipedProfile.userId!,
      action: direction == CardSwiperDirection.right ? "like" : "dislike",
    );

    /// 🚫 DO NOT update currentIndex using swiper index
    /// We always keep index at 0 because we remove items

    /// 🕒 Delay removal to avoid RangeError
    currentIndex.value = newIndex;
    profileListCount.removeAt(0);
    
    if (profileList.isNotEmpty) {
      _updateInShort();
      
      // Preload next image
      final nextIndex = newIndex + 2;
      if (nextIndex < profileList.length && 
          profileList[nextIndex].mainPhoto != null &&
          profileList[nextIndex].mainPhoto!.isNotEmpty) {
        CachedNetworkImageProvider(profileList[nextIndex].mainPhoto!)
            .resolve(const ImageConfiguration());
      }
    }

    if (profileListCount.isEmpty) {
      _loadMoreProfilesIfNeeded();
    }
    return true;
  }

  void _loadMoreProfilesIfNeeded() async {
    await getProfileList(filterType: "basic", filter: 10);
  }

  /* ----------------------------------------------------
   * LIKE / DISLIKE BUTTON TAP
   * -------------------------------------------------- */

  // void handleInteraction({required bool isLikeAction}) async {
  //   final profile = currentProfile;
  //   if (profile == null) return;

  //   isLike.value = isLikeAction;
  //   isOverlay.value = true;

  //   await createInterection(
  //     userId: profile.userId!,
  //     action: isLikeAction ? "like" : "dislike",
  //   );

  //   Future.delayed(const Duration(seconds: 2), () {
  //     isOverlay.value = false;
  //     isLike.value = false;
  //     swiperController.swipe(
  //       isLikeAction ? CardSwiperDirection.right : CardSwiperDirection.left,
  //     );
  //   });
  //    Future.delayed(const Duration(milliseconds: 300), () {
  //     if (previousIndex < profileList.length) {
  //       profileList.removeAt(previousIndex);
  //     }

  //     /// Update UI safely
  //     if (profileList.isNotEmpty) {
  //       _updateInShort();
  //     }

  //     /// 🚀 Load more when only 1 left
  //     if (profileList.length <= 1) {
  //       _loadMoreProfilesIfNeeded();
  //     }
  //   });
  //   if (profileList.isNotEmpty) {
  //     _updateInShort();
  //   }

  //   /// 🚀 Load more if only 1 left
  //   _loadMoreProfilesIfNeeded();
  // }
  void handleInteraction({required bool isLikeAction}) {
    if (profileList.isEmpty) return;

    /// Show overlay animation
    isLike.value = isLikeAction;
    isOverlay.value = true;

    /// Hide overlay after animation
    Future.delayed(const Duration(seconds: 1), () {
      isOverlay.value = false;
      isLike.value = false;

      /// Trigger swipe ONLY
      swiperController.swipe(
        isLikeAction ? CardSwiperDirection.right : CardSwiperDirection.left,
      );
    });
  }

  /* ----------------------------------------------------
   * UPDATE "IN SHORT"
   * -------------------------------------------------- */
  void playLike() {
    showLike.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      showLike.value = false;
    });
  }

  Future<void> _updateInShort() async {
    final profile = currentProfile;
    if (profile == null) {
      inShortList.clear();
      inshortList.clear();
      return;
    }
    inshortList.clear();
    if (profile.gender != null && profile.gender!.isNotEmpty) {
      final vlaue = GenderEnumX.fromApi(profile.gender!);
      if (vlaue != null) {
        inshortList.add(
          InshortList(text: profile.gender.toString(), img: vlaue.emoji),
        );
      }
    }
    if (profile.smoking!.isNotEmpty) {
      final freq = frequencyFromApi(profile.smoking!);
      if (freq != null) {
        final smokeOption = HabitOption(
          type: HabitTypeEnum.smoke,
          frequency: freq,
        );
        inshortList.add(
          InshortList(text: smokeOption.label, img: smokeOption.emoji),
        );
      }
    }
    if (profile.drinking != null && profile.drinking!.isNotEmpty) {
      final freq = frequencyFromApi(profile.drinking!);
      if (freq != null) {
        final drinkOption = HabitOption(
          type: HabitTypeEnum.drinking,
          frequency: freq,
        );
        inshortList.add(
          InshortList(text: drinkOption.label, img: drinkOption.emoji),
        );
      }
    }

    if (profile.religion != null && profile.religion!.isNotEmpty) {
      final value = ReligionEnumX.fromApi(profile.religion!);

      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if (profile.zodiacSign != null && profile.zodiacSign!.isNotEmpty) {
      final value = ZodiacEnumX.fromApi(profile.zodiacSign!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }
    if (profile.height != null && profile.height!.isNotEmpty) {
      final value = HeightEnumExt.fromApi(profile.height!);
      if (value != null) {
        inshortList.add(
          InshortList(text: profile.height.toString(), img: value.emoji),
        );
      }
    }

    inShortList
      ..clear()
      ..addAll(
        [
              profile.gender,
              profile.smoking,
              profile.drinking,
              profile.religion,
              profile.zodiacSign,
              profile.height,
            ]
            .where((e) => e != null && e.toString().trim().isNotEmpty)
            .cast<String>(),
      );
  }

  Future<void> preloadInitialCachedImages(List<Profile> images) async {
    for (int i = 0; i < 3 && i < images.length; i++) {
      CachedNetworkImageProvider(
        images[i].mainPhoto!,
      ).resolve(const ImageConfiguration());
    }
  }

  Future<void> preloadInitialCards(
    BuildContext context,
    List<Profile> images,
  ) async {
    final preloadCount = images.length >= 3 ? 3 : images.length;

    for (int i = 0; i < preloadCount; i++) {
      await precacheImage(
        CachedNetworkImageProvider(images[i].mainPhoto!),
        context,
      );
    }
  }

  /* ----------------------------------------------------
   * CLEANUP
   * -------------------------------------------------- */

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  List<HabitOption> buildHabitOptions(
    HabitTypeEnum type, {
    Set<FrequencyEnum>? exclude,
  }) {
    return FrequencyEnum.values
        .where((e) => exclude == null || !exclude.contains(e))
        .map((e) => HabitOption(type: type, frequency: e))
        .toList();
  }

  // void _loadMoreProfilesIfNeeded() {
  //   if (profileList.length == 2 && !isFetchingMore.value) {
  //     isFetchingMore.value = true;
  //     getProfileList(filterType: 'basic', filter: 10).then((_) {
  //       isFetchingMore.value = false;
  //     });
  //   }
  // }
}

FrequencyEnum frequencyFromApi(String value) {
  return FrequencyEnum.values.firstWhere(
    (e) => e.name == value.toLowerCase(),
    orElse: () => FrequencyEnum.values.first,
  );
}
