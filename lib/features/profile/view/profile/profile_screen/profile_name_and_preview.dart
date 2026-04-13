import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart'
    show ProfileController;
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileNameAndPreview extends StatelessWidget {
  const ProfileNameAndPreview({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Row(
            children: [
              CommonText.titleMedium(
                "${controller.basicInfo.value.name}, ${controller.basicInfo.value.age}",

                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
              10.wBox,
              SvgPicture.asset(AppAssets.verified),
            ],
          ),
        ),
        5.hBox,
        InkWell(
          onTap: () {
            AppNavigation.to(AppRoutes.profilePreviewScreen);
          },
          child: Container(
            padding: 15.horizontalPadding + 2.verticalPadding,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xffDEDEDE)),
            ),
            child: CommonText.text(
              AppStrings.preview,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            ),
          ),
        ),
      ],
    );
  }
}
