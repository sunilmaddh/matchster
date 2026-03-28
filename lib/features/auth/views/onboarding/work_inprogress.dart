import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class MaintenceScreen extends StatelessWidget {
  const MaintenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        onTop: () {
          Get.back();
        },
      ),
      body: Container(
        height: Get.height,
        color: AppColors.borderColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              width: 500.w,
              height: 300.h,
              AppAssets.maintence,
            ),
            20.hBox,

            CommonText.text(
              "Work in progress",
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontSize: 30.sp,
            ),
          ],
        ),
      ),
    );
  }
}
