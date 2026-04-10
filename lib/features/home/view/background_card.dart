import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/home/controller/home_controller.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (homeController.profileList.length > 2)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.80,
              margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                child: Obx(() {
                  final nextIndex = homeController.currentIndex.value + 2;
                  if (nextIndex < homeController.profileList.length) {
                    return CommonAssets.networkImage(
                      homeController.profileList[nextIndex].mainPhoto ?? '',
                      fit: BoxFit.cover,
                    );
                  }
                  return Container(color: AppColors.whiteColor);
                }),
              ),
            ),
          ),

        /// BACKGROUND CARD 1 (MIDDLE)
        if (homeController.profileList.length > 1)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.90,
              margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                child: Obx(() {
                  final nextIndex = homeController.currentIndex.value + 1;
                  if (nextIndex < homeController.profileList.length) {
                    return CommonAssets.networkImage(
                      homeController.profileList[nextIndex].mainPhoto ?? '',
                      fit: BoxFit.cover,
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ),
          ),
      ],
    );
  }
}
