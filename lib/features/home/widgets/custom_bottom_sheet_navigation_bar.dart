import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/features/common/widgets/card/circle_gradiant_card.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/home/controller/home_controller.dart';

class CustomBottomNavigationBar extends BaseView<HomeController> {
  const CustomBottomNavigationBar({super.key, required this.pageList});

  final List<Widget> pageList;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();

  @override
  bool get useDefaultLoader => false;
}

class _CustomBottomNavigationBarState
    extends BaseViewState<HomeController, CustomBottomNavigationBar> {
  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            _buildPageView(),
            _buildBottomGradient(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(_buildBottomNavigation),
            ),
            Obx(_buildOverlay),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: widget.pageList,
    );
  }

  Widget _buildBottomGradient() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40,
      child: IgnorePointer(
        child: Container(
          height: 35,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    if (!controller.isOverlay.value) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      color: Colors.white.withAlpha(153),
      child: Hero(
        tag: 'like_dislike',
        transitionOnUserGestures: true,
        child: CircleGradiantCard(
          isGradiant: controller.isLike.value,
          widget: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              controller.isLike.value
                  ? AppAssets.likeAssets
                  : AppAssets.dislike,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xffE6E6E6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: AppStrings.home,
                  icon: AppAssets.homeAssets,
                ),
                _buildNavItem(
                  index: 1,
                  label: AppStrings.likes,
                  icon: AppAssets.likesAssets,
                ),
                _buildNavItem(
                  index: 2,
                  label: AppStrings.premium,
                  icon: AppAssets.premuimAssets,
                ),
                _buildNavItem(
                  index: 3,
                  label: AppStrings.chats,
                  icon: AppAssets.chatAssets,
                ),
                _buildNavItem(
                  index: 4,
                  label: AppStrings.profile,
                  icon: AppAssets.profileAssets,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String icon,
  }) {
    final bool isSelected = controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => controller.onTabTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              height: 22,
              color: isSelected ? AppColors.primary : AppColors.blackColor,
            ),
            const SizedBox(height: 4),
            CommonText.labelMedium(
              label,
              color: isSelected ? AppColors.primary : AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
