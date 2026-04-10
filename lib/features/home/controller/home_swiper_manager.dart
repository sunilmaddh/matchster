import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/home/mixin/home_profile_mixin.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/request/create_interaction_request.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';

mixin HomeSwipeManager on BaseController {
  HomeRepository get homeRepository;
  HomeProfileMixin get homeProfileMixin;

  RxList<Profile> get profileList;
  RxList<String> get swipedUserIds;
  RxInt get currentIndex;
  RxInt get swiperKey;

  RxBool get showLike;
  RxBool get isOverlayVisible;
  RxBool get isLikeAction;
  RxBool get isLoadingMore;

  bool get isProgrammaticSwipe;
  set isProgrammaticSwipe(bool value);

  CardSwiperController get swiperController;
  Profile? get currentProfile;

  void updateInShort();

  void markCardAsSwiped(String? userId) {
    if (userId == null || userId.isEmpty) return;

    if (!swipedUserIds.contains(userId)) {
      swipedUserIds.add(userId);
    }
  }

  void removeAllSwipedCardsAndReset() {
    if (profileList.isEmpty || swipedUserIds.isEmpty) return;

    final swipedIds = swipedUserIds.toSet();
    profileList.removeWhere((item) => swipedIds.contains(item.userId));

    swipedUserIds.clear();
    currentIndex.value = 0;
    swiperKey.value++;
    updateInShort();
  }

  void removeSingleCardById(String userId) {
    profileList.removeWhere((item) => item.userId == userId);

    if (currentIndex.value >= profileList.length) {
      currentIndex.value = profileList.isNotEmpty ? profileList.length - 1 : 0;
    }

    updateInShort();
  }

  Future<void> createInteraction({
    required String userId,
    required String action,
  }) async {
    try {
      final request = CreateInteractionRequest(userId: userId, action: action);

      final response = await homeRepository.createInterection(request: request);

      if (!response.success) {
        AppMethods.appPrint(message: response.message);
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
    if (profileList.isEmpty) return false;
    if (previousIndex < 0 || previousIndex >= profileList.length) return false;

    final profile = profileList[previousIndex];
    final liked = direction == CardSwiperDirection.right;

    if (!isProgrammaticSwipe) {
      if (liked) {
        playLike();
      }

      if (profile.userId != null && profile.userId!.isNotEmpty) {
        createInteraction(
          userId: profile.userId!,
          action: liked ? 'like' : 'dislike',
        );
      }
    }

    isProgrammaticSwipe = false;
    markCardAsSwiped(profile.userId);

    if (newIndex != null && newIndex >= 0 && newIndex < profileList.length) {
      currentIndex.value = newIndex;
    } else {
      final nextIndex = previousIndex + 1;
      currentIndex.value =
          nextIndex < profileList.length ? nextIndex : previousIndex;
    }

    updateInShort();

    if (newIndex == null || newIndex >= profileList.length - 2) {
      loadMoreProfilesIfNeeded();
    }

    return true;
  }

  void handleInteraction({required bool isLike}) {
    final profile = currentProfile;
    if (profile == null) return;

    isLikeAction.value = isLike;
    isOverlayVisible.value = true;

    if (isLike) {
      playLike();
    }

    if (profile.userId != null && profile.userId!.isNotEmpty) {
      createInteraction(
        userId: profile.userId!,
        action: isLike ? 'like' : 'dislike',
      );
    }
    Future.delayed(const Duration(milliseconds: 350), () {
      isOverlayVisible.value = false;
      isLikeAction.value = false;

      isProgrammaticSwipe = true;
      swiperController.swipe(
        isLike ? CardSwiperDirection.right : CardSwiperDirection.left,
      );
    });
  }

  Future<void> loadMoreProfilesIfNeeded() async {
    if (isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;
      await homeProfileMixin.loadProfiles(showLoader: false);
    } finally {
      isLoadingMore.value = false;
    }
  }

  void playLike() {
    showLike.value = true;
    Future.delayed(const Duration(milliseconds: 700), () {
      showLike.value = false;
    });
  }
}
