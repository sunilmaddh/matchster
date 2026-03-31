import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileVerificationSection extends GetView<ProfileController> {
  const ProfileVerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(AppStrings.verifyYourProfile),
          5.hBox,
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: InkWell(
              onTap: () => controller.navigateTo(AppRoutes.faceCamera),
              child: InterestCard(
                color: AppColors.verifiedCardColor,
                title: AppStrings.getVerified,
                subTitle: AppStrings.showOthersYouAreReal,
                image: AppAssets.verified2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
