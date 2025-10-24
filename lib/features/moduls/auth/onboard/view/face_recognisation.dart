import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/home/profile/view/profile_screen.dart';

class FaceRecogonizationWidget extends StatelessWidget {
  FaceRecogonizationWidget({super.key});
  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(ProfileScreen());
        },
        child: Container(
          alignment: Alignment.center,
          height: 68.h,
          width: 68.w,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: Color(0xffC6C6C6), width: 4.w),
            shape: BoxShape.circle,
          ),
          child: Container(
            margin: EdgeInsets.all(2.r),
            alignment: Alignment.center,
            height: 68.h,
            width: 68.w,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: Color(0xffDEDEDE), width: 1.w),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Face Recognisation",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              maxLines: 4,
              AppConstants.faceRecogonization,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff7B7B7B),
            ),
            30.hBox,
            Padding(
              padding: 30.horizontalPadding,
              child: Image.asset(AppAssets.photoFrame1),
            ),
            30.hBox,
          ],
        ),
      ),
    );
  }
}
