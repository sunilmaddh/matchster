import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class EmailVerificationSection extends StatelessWidget {
  const EmailVerificationSection({super.key, required this.controller});

  final ProfileController controller;

  bool get isEmailMissing =>
      controller.basicInfo.value.email == null ||
      controller.basicInfo.value.email!.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.hBox,
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: InkWell(
              onTap: () {
                if (isEmailMissing) {
                  AppNavigation.to(AppRoutes.verifyEmailScreen);
                }
              },
              child: InterestCard(
                showBackArrow: isEmailMissing,
                color: const Color(0xff1D48EF),
                title:
                    isEmailMissing
                        ? AppStrings.verifyEmail
                        : AppStrings.emailVerified,
                subTitle:
                    isEmailMissing
                        ? AppStrings.confirmItsReallyYou
                        : AppStrings.yourEmailIsVerified,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
