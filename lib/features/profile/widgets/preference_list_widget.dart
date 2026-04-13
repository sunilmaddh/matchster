import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

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
        CommonText.titleMedium("Preferences"),
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
              AppNavigation.to(AppRoutes.workoutScreen);
            },
            child: InterestCard(
              title: "Workout",
              subTitle: AppMethods.capitalizeFirst(
                lifestyle.workout ?? "Not available",
              ),
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
              AppNavigation.to(AppRoutes.smokeScreen);
            },
            child: InterestCard(
              color: Color(0xffDEB4B4),
              title: 'Smoking',
              subTitle: AppMethods.capitalizeFirst(
                lifestyle.smoking ?? "Not available",
              ),
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
              AppNavigation.to(AppRoutes.alcohalScreen);
            },
            child: InterestCard(
              color: Color(0xffDEB4C8),
              title: 'Drinking',
              subTitle: AppMethods.capitalizeFirst(
                lifestyle.drinking ?? "Not available",
              ),
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
              AppNavigation.to(AppRoutes.interestScreen);
            },
            child: InterestCard(
              color: Color(0xffB4B8DE),
              title: 'Interest',
              subTitle: (personal.interests ?? []).capitalizeFirstAndJoin(),
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
              AppNavigation.to(AppRoutes.languagesScreen);
            },
            child: InterestCard(
              color: Color(0xff85CFCF),
              title: 'Languages',
              subTitle: (personal.languages ?? []).capitalizeFirstAndJoin(),
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
      ],
    );
  }
}
