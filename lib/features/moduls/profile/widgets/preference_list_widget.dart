import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/view/interest/alcohal_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/interest_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/languages_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/smoke_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/workout_screen.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_card.dart';

class PreferenceListWidget extends StatelessWidget {
  const PreferenceListWidget({
    super.key,
    required this.lifestyle,
    required this.personal,
  });
  final Lifestyle lifestyle;
  final Personal personal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText.text(
          "Preference",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "Caros",
        ),
        5.hBox,
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(WorkoutScreen());
            },
            child: InterestCard(
              title: "Workout",
              subTitle: lifestyle.workout!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(SmokeScreen());
            },
            child: InterestCard(
              title: 'Smoking',
              subTitle: lifestyle.smoking!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(AlcohalScreen());
            },
            child: InterestCard(
              title: 'Drinking',
              subTitle: lifestyle.drinking!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(InterestScreen());
            },
            child: InterestCard(
              title: 'Interest',
              subTitle: personal.interests!.join(", "),
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(LanguagesScreen());
            },
            child: InterestCard(
              title: 'Languages',
              subTitle: personal.languages!.join(", "),
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
      ],
    );
  }
}
