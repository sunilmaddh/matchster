import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileDetailsListScreen extends StatelessWidget {
  ProfileDetailsListScreen({
    super.key,
    required this.personal,
    required this.preference,
    required this.professional,
    required this.basicInfo,
  });

  final Personal personal;
  final Preferences preference;
  final Professional professional;
  final BasicInfo basicInfo;

  final ProfileController _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final String workTitle = professional.work?.jobTitle ?? '';
    final String companyName = professional.work?.company ?? '';

    final String workSubtitle = [
      if (workTitle.isNotEmpty) AppMethods.capitalizeFirst(workTitle),
      if (companyName.isNotEmpty) AppMethods.capitalizeFirst(companyName),
    ].join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.titleMedium(AppStrings.profileDetails),
        5.hBox,

        /// Zodiac Sign
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (personal.zodiacSign != null &&
                  personal.zodiacSign!.isNotEmpty) {
                _controller.selectedZodiac.value = personal.zodiacSign!;
              } else {
                _controller.selectedZodiac.value = "";
              }
              AppNavigation.to(AppRoutes.zodiacScreen);
            },
            child: InterestCard(
              color: const Color(0xffB4CADE),
              title: AppStrings.zodiacSign,
              subTitle: AppMethods.capitalizeFirst(
                personal.zodiacSign ?? AppStrings.notAvailable,
              ),
              image: AppAssets.zodizcAssets,
            ),
          ),
        ),

        /// Religion
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (personal.religion != null && personal.religion!.isNotEmpty) {
                _controller.selectedReligion.value = personal.religion!;
              } else {
                _controller.selectedReligion.value = "";
              }
              AppNavigation.to(AppRoutes.religionScreen);
            },
            child: InterestCard(
              color: const Color(0xffB4DEC5),
              title: AppStrings.religion,
              subTitle:
                  (personal.religion ?? "").isNotEmpty
                      ? (personal.religion ?? "").removeSnakeAndCapitalize()
                      : AppStrings.notAvailable,
              image: AppAssets.religionAssest,
            ),
          ),
        ),

        /// Profile Visibility
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (preference.visibility != null &&
                  preference.visibility!.isNotEmpty) {
                _controller.selectedVisibility.value = preference.visibility!;
              } else {
                _controller.selectedVisibility.value = "";
              }
              AppNavigation.to(AppRoutes.visibilityScreen);
            },
            child: InterestCard(
              color: const Color(0xffDEDCB4),
              title: AppStrings.profileVisibility,
              subTitle:
                  (preference.visibility ?? "").isNotEmpty
                      ? (preference.visibility ?? "").removeSnakeAndCapitalize()
                      : AppStrings.notAvailable,
              image: AppAssets.profileEditAssets,
            ),
          ),
        ),

        /// Looking For
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (preference.lookingFor != null &&
                  preference.lookingFor!.isNotEmpty) {
                _controller.setLookingFromApi(preference.lookingFor);
              } else {
                _controller.selectedLookingFor();
              }
              AppNavigation.to(AppRoutes.lookingScreen);
            },
            child: Obx(
              () => InterestCard(
                color: const Color(0xffB4CADE),
                title: AppStrings.lookingFor,
                subTitle:
                    (_controller.prefeence.value.lookingFor ?? "").isNotEmpty
                        ? (_controller.prefeence.value.lookingFor ?? "")
                            .removeSnakeAndCapitalize()
                        : AppStrings.notAvailable,
                image: AppAssets.lookingAssets,
              ),
            ),
          ),
        ),

        /// Height
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (basicInfo.height != null && basicInfo.height!.isNotEmpty) {
                _controller.heightController.value = basicInfo.height!;
              } else {
                _controller.heightController.value = "";
              }
              AppNavigation.to(AppRoutes.heightScreen);
            },
            child: InterestCard(
              color: const Color(0xffE5C3FF),
              title: AppStrings.height,
              subTitle: AppMethods.capitalizeFirst(
                basicInfo.height ?? AppStrings.notAvailable,
              ),
              image: AppAssets.heightAssets,
            ),
          ),
        ),

        /// Education
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (personal.qualification != null &&
                  personal.qualification!.isNotEmpty) {
                _controller.qualification.value = personal.qualification!;
                final int index = CommonLists.studieList.indexWhere(
                  (element) =>
                      element.toLowerCase() ==
                      personal.qualification!
                          .replaceAll('_', ' ')
                          .toLowerCase(),
                );
                _controller.selectedEduIndex.value = index;
              } else {
                _controller.qualification.value = "";
              }
              AppNavigation.to(AppRoutes.educationScreen);
            },
            child: InterestCard(
              color: const Color(0xff92C58F),
              title: AppStrings.education,
              subTitle:
                  (personal.qualification ?? "").isNotEmpty
                      ? (personal.qualification ?? "")
                          .removeSnakeAndCapitalize()
                      : AppStrings.notAvailable,
              image: AppAssets.educationAssets,
            ),
          ),
        ),

        /// Work
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (_controller.professional.value.work != null &&
                  _controller.professional.value.work!.jobTitle!.isNotEmpty) {
                _controller.jobTtileController.text =
                    _controller.professional.value.work!.jobTitle!;
                _controller.companyController.text =
                    _controller.professional.value.work!.company!;
              } else {
                _controller.jobTtileController.clear();
                _controller.companyController.clear();
              }

              AppNavigation.to(AppRoutes.workScreen);
            },
            child: InterestCard(
              color: const Color(0xffA2D2FF),
              title: AppStrings.work,
              subTitle:
                  workSubtitle.isNotEmpty
                      ? workSubtitle
                      : AppStrings.notAvailable,
              image: AppAssets.workAssets,
            ),
          ),
        ),
      ],
    );
  }
}
