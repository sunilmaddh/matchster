import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  late PageController pageController;
  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentIndex = 0.obs;
}
