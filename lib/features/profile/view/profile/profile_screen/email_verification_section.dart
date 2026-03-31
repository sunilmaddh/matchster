import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class EmailVerificationSection extends GetView<ProfileController> {
  const EmailVerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final email = controller.basicInfo?.email ?? '';
      final isVerified = email.trim().isNotEmpty;

      return Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: InkWell(
                onTap: () {
                  if (!isVerified) {
                    AppNavigation.to(AppRoutes.verifyEmailScreen);
                  }
                },
                child: InterestCard(
                  showBackArrow: !isVerified,
                  color: AppColors.verifiedCardColor,
                  title:
                      isVerified
                          ? AppStrings.emailVerified
                          : AppStrings.verifyEmail,
                  subTitle:
                      isVerified
                          ? AppStrings.yourEmailIsVerified
                          : AppStrings.confirmItsReallyYou,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
