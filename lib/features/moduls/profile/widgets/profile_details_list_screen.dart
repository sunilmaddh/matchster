import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/view/interest/looking_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/religion_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/visibility_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/zodiac_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/education_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/height_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/work_screen.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_card.dart';

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

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.text(
          "Profile Details",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "Caros",
        ),
        5.hBox,
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
              Get.to(() => ZodiacScreen());
            },
            child: InterestCard(
              color: Color(0xffB4CADE),
              title: 'Zodiac Sign',
              subTitle: AppMethods.capitalizeFirst(
                personal.zodiacSign ?? "Not available",
              ),
              image: AppAssets.zodizcAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (personal.religion != null && personal.religion!.isNotEmpty) {
                _controller.selectedReligion.value = personal.religion!;
              } else {
                _controller.selectedReligion.value = "";
              }
              Get.to(() => ReligionScreen());
            },
            child: InterestCard(
              color: Color(0xffB4DEC5),
              title: 'Religion',
              subTitle: (personal.religion ?? "").removeSnakeAndCapitalize(),
              image: AppAssets.religionAssest,
            ),
          ),
        ),
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
              Get.to(() => VisibilityScreen());
            },
            child: InterestCard(
              color: Color(0xffDEDCB4),
              title: 'Profile Visibility',
              subTitle:
                  (preference.visibility ?? "").removeSnakeAndCapitalize(),
              image: AppAssets.profileEditAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (preference.lookingFor != null &&
                  preference.lookingFor!.isNotEmpty) {
                _controller.setLookingFromApi(preference.lookingFor);
              } else {
                _controller.selectedLookingFor.clear();
              }
              Get.to(() => LookingScreen());
            },
            child: InterestCard(
              color: Color(0xffB4CADE),
              title: 'Looking For',
              subTitle: (preference.lookingFor ?? []).capitalizeFirstAndJoin(),
              image: AppAssets.lookingAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (basicInfo.height != null && basicInfo.height!.isNotEmpty) {
                _controller.heightController.value = basicInfo.height!;
              } else {
                _controller.heightController.value = "";
              }
              Get.to(() => HeightScreen());
            },
            child: InterestCard(
              color: Color(0xffE5C3FF),
              title: 'Height',
              subTitle: AppMethods.capitalizeFirst(
                basicInfo.height ?? "Not available",
              ),
              image: AppAssets.heightAssets,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              if (personal.qualification != null &&
                  personal.qualification!.isNotEmpty) {
                _controller.qualification.value = personal.qualification!;
                int index = CommonLists.studieList.indexWhere(
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
              Get.to(() => EducationScreen());
            },
            child: InterestCard(
              color: Color(0xff92C58F),
              title: 'Education',
              subTitle:
                  (personal.qualification ?? "").removeSnakeAndCapitalize(),
              image: AppAssets.educationAssets,
            ),
          ),
        ),
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

              Get.to(() => WorkScreen());
            },
            child: InterestCard(
              color: Color(0xffA2D2FF),
              title: 'Work',
              subTitle:
                  "${AppMethods.capitalizeFirst(professional.work?.jobTitle ?? '')}, ${AppMethods.capitalizeFirst(professional.work?.company ?? '')}",
              image: AppAssets.workAssets,
            ),
          ),
        ),
      ],
    );
  }
}
