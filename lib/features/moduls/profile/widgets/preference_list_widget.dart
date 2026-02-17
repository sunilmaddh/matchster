import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/view/interest/alcohal_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/interest_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/languages_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/smoke_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/workout_screen.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_card.dart';

class PreferenceListWidget extends StatelessWidget {
  PreferenceListWidget({
    super.key,
    required this.lifestyle,
    required this.personal,
  });
  final Lifestyle lifestyle;
  final Personal personal;

  final _comtroller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText.text(
          "Preferences",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "Caros",
        ),
        5.hBox,
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (lifestyle.workout != null && lifestyle.workout!.isNotEmpty) {
                _comtroller.selectedWorkout.value = lifestyle.workout!;
              } else {
                _comtroller.selectedWorkout.value = "";
              }
              Get.to(() => WorkoutScreen());
            },
            child: InterestCard(
              title: "Workout",
              subTitle: AppMethods.capitalizeFirst(lifestyle.workout!),
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (lifestyle.smoking != null && lifestyle.smoking!.isNotEmpty) {
                _comtroller.selectedSmoke.value = lifestyle.smoking!;
              } else {
                _comtroller.selectedSmoke.value = "";
              }
              Get.to(() => SmokeScreen());
            },
            child: InterestCard(
              color: Color(0xffDEB4B4),
              title: 'Smoking',
              subTitle: AppMethods.capitalizeFirst(lifestyle.smoking!),
              image: AppAssets.smokingAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (lifestyle.drinking != null &&
                  lifestyle.drinking!.isNotEmpty) {
                _comtroller.selectedDrinking.value = lifestyle.drinking!;
              } else {
                _comtroller.selectedDrinking.value = "";
              }
              Get.to(() => AlcohalScreen());
            },
            child: InterestCard(
              color: Color(0xffDEB4C8),
              title: 'Drinking',
              subTitle: AppMethods.capitalizeFirst(lifestyle.drinking!),
              image: AppAssets.drinkAsssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () async {
              if (personal.interests != null &&
                  personal.interests!.isNotEmpty) {
                _comtroller.loadFromApi(personal.interests!);
              } else {
                _comtroller.selectedInterests.clear();
              }
              Get.to(() => InterestScreen());
            },
            child: InterestCard(
              color: Color(0xffB4B8DE),
              title: 'Interest',
              subTitle: personal.interests!.capitalizeFirstAndJoin(),
              image: AppAssets.interestAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () async {
              if (personal.languages != null &&
                  personal.languages!.isNotEmpty) {
                await _comtroller.setLanguageFromApi(personal.languages);
              } else {
                _comtroller.selectedInterests.clear();
              }
              Get.to(() => LanguagesScreen());
            },
            child: InterestCard(
              color: Color(0xff85CFCF),
              title: 'Languages',
              subTitle: personal.languages!.capitalizeFirstAndJoin(),
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
      ],
    );
  }
}
