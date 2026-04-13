import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';

class ProfileVerificationSection extends StatelessWidget {
  const ProfileVerificationSection({super.key, required this.controller});

  final ProfileController controller;

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
              onTap: () {},
              child: InterestCard(
                color: const Color(0xff1D48EF),
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
