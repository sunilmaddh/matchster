import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
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
  final RxList<Datum> likeList = <Datum>[].obs;
  final RxList<String> inShortList = <String>[].obs;

  final RxInt selectedIndex = 0.obs;
  final RxInt currentIndex = 0.obs;

  final RxBool isGettingProfile = false.obs;
  final RxBool isOverlay = false.obs;
  final RxBool isLike = false.obs;

  final HomeServices _homeService = HomeServices();

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
    pageController.jumpToPage(index);
  }

  /* ----------------------------------------------------
   * PROFILE LIST
   * -------------------------------------------------- */

  Future<void> getProfileList({
    required String filterType,
    required int filter,
  }) async {
    try {
      isGettingProfile(true);

      final response = await _homeService.getProfileLisr(
        filterType: filterType,
        filter: filter,
      );

      if (response.success && response.data?.profiles != null) {
        profileList.assignAll(response.data!.profiles!);
        currentIndex.value = 0;
        _updateInShort();
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    } finally {
      isGettingProfile(false);
    }
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
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex == null) return true;
    if (currentIndex < 0 || currentIndex >= profileList.length) {
      return true;
    }

    this.currentIndex.value = currentIndex;
    _updateInShort();
    if (direction == CardSwiperDirection.left) {
      createInterection(
        userId: profileList[previousIndex].userId!,
        action: "dislike",
      );
    } else if (direction == CardSwiperDirection.right) {
      createInterection(
        userId: profileList[previousIndex].userId!,
        action: "dislike",
      );
    }

    return true;
  }

  /* ----------------------------------------------------
   * LIKE / DISLIKE BUTTON TAP
   * -------------------------------------------------- */

  void handleInteraction({required bool isLikeAction}) async {
    final profile = currentProfile;
    if (profile == null) return;

    isLike.value = isLikeAction;
    isOverlay.value = true;

    await createInterection(
      userId: profile.userId!,
      action: isLikeAction ? "like" : "dislike",
    );

    Future.delayed(const Duration(seconds: 2), () {
      isOverlay.value = false;
      isLike.value = false;
      swiperController.swipe(
        isLikeAction ? CardSwiperDirection.right : CardSwiperDirection.left,
      );
    });
  }

  /* ----------------------------------------------------
   * UPDATE "IN SHORT"
   * -------------------------------------------------- */

  void _updateInShort() {
    final profile = currentProfile;
    if (profile == null) {
      inShortList.clear();
      return;
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

  /* ----------------------------------------------------
   * CLEANUP
   * -------------------------------------------------- */

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
