import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/models/like_response.dart';
import 'package:matchster/features/moduls/home/services/home_services.dart';
import 'package:matchster/test_main.dart';

class HomeController extends GetxController {
  RxList<Profile> profileList = <Profile>[].obs;
  Rx<Profile> profile = Profile().obs;
  final _homeService = HomeServices();
  RxList<String> inShortList = <String>[].obs;
  RxList<Datum> likeList = <Datum>[].obs;
  RxInt selectedIndex = 0.obs;
  RxBool isGettingProfile = false.obs;
  late PageController pageController;
  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  RxBool isOverlay = false.obs;
  RxBool isLike = false.obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentIndex = 0.obs;

  final CardSwiperController swiperController = CardSwiperController();

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
      if (response.success) {
        final data = response.data;
        if (data != null) {
          profileList.value = data.profiles!;
          updateList();
        }
        isGettingProfile(false);
      } else {
        AppMethods.appPrint(message: response.message);
        isGettingProfile(false);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      isGettingProfile(false);
    }
  }

  Future<void> createInterection({
    required String userId,
    required String action,
  }) async {
    try {
      final response = await _homeService.createInterection(
        userId: userId,
        action: action,
      );
      if (response.success) {
      } else {
        AppMethods.appPrint(message: response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> getLikeOnMe() async {
    try {
      final response = await _homeService.likeOnMe();
      if (response.success) {
        final data = response.data;
        if (data != null) {
          likeList.value = data.data;
        }
      } else {
        AppToastMessage.show(title: "Error", message: response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  void callGetProfile() {
    if (profileList.isEmpty) {
      getProfileList(filterType: "basic", filter: 10);
    }
  }

  void updateList() {
    if (profileList.isEmpty) {
      inShortList.clear();
    } else {
      inShortList.clear();
      final nextProfile = profileList.first;
      profile.value = nextProfile;
      if (nextProfile != null) {
        inShortList.addAll(
          [
                nextProfile.gender,
                nextProfile.smoking,
                nextProfile.drinking,
                nextProfile.religion,
                nextProfile.zodiacSign,
                nextProfile.height,
              ]
              .where((e) => e != null && e.toString().trim().isNotEmpty)
              .cast<String>(),
        );
      }
      profileList.removeAt(0);
    }
  }

  final List<ProfileDemo> profiles = [
    ProfileDemo(
      name: "Emma",
      age: 24,
      image: "https://picsum.photos/400/600?1",
    ),
    ProfileDemo(
      name: "Sophia",
      age: 26,
      image: "https://picsum.photos/400/600?2",
    ),
    ProfileDemo(
      name: "Olivia",
      age: 23,
      image: "https://picsum.photos/400/600?3",
    ),
    ProfileDemo(name: "Ava", age: 25, image: "https://picsum.photos/400/600?4"),
  ];
  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final profile = profiles[previousIndex];

    if (direction == CardSwiperDirection.right) {
      debugPrint("Liked ${profile.name}");
    } else if (direction == CardSwiperDirection.left) {
      debugPrint("Disliked ${profile.name}");
    }

    return true;
  }
}
