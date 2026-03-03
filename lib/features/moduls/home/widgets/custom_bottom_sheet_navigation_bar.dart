import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/card/circle_gradiant_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.pageList});
  final List<Widget> pageList;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },

      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller.pageController,
              onPageChanged: _controller.onTabTapped,
              children: widget.pageList,
            ),
            Positioned(
              left: 0,
              right: 0,

              bottom: 40,
              child: IgnorePointer(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white],
                    ),
                  ),
                ),
              ),
            ),

            /// 🔹 Bottom navigation
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(() => _bottomNavigation()),
            ),
            Obx(
              () =>
                  _controller.isOverlay.isTrue
                      ? Container(
                        alignment: Alignment.center,
                        color: Colors.white.withAlpha(153),
                        child: Hero(
                          tag: "like_dislike",
                          transitionOnUserGestures: true,

                          child: CircleGradiantCard(
                            isGradiant:
                                _controller.isLike.isTrue ? true : false,
                            widget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                _controller.isLike.isTrue
                                    ? AppAssets.likeAssets
                                    : AppAssets.dislike,
                              ),
                            ),
                          ),
                        ),
                      )
                      : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HOME BACKGROUND =================
  // Widget _homeBackground() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.bottomCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           const Color(0xFF7A96F8).withValues(alpha: 0),
  //           const Color(0xFF587DFF).withValues(alpha: 128),
  //           const Color(0xFF5174FF).withValues(alpha: 191), // 0.75
  //           const Color(0xFF3F66FF).withValues(alpha: 222), // 0.87
  //           const Color(0xFF1D48EF).withValues(alpha: 0), // 0.0
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ================= BOTTOM NAV =================
  Widget _bottomNavigation() {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8.0),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Color(0xffE6E6E6)),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, "Home", AppAssets.homeAssets),
              _navItem(1, "Likes", AppAssets.likesAssets),
              _navItem(2, "Premium", AppAssets.premuimAssets),
              _navItem(3, "Chats", AppAssets.chatAssets),
              _navItem(4, "Profile", AppAssets.profileAssets),
            ],
          ),
        ),
      ),
    );
  }

  // ================= NAV ITEM =================
  Widget _navItem(int index, String label, String icon) {
    final bool selected = _controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => _controller.onTabTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 22,
            color: selected ? AppColors.primary : AppColors.blackColor,
            // const Color(0xFF9AA0A6),
          ),
          const SizedBox(height: 4),
          CommonText.text(
            label,
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.primary : AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
