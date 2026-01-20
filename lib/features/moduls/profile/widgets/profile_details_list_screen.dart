import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/view/interest/looking_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/religion_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/visibility_screen.dart';
import 'package:matchster/features/moduls/profile/view/interest/zodiac_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/education_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/height_screen.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_card.dart';

class ProfileDetailsListScreen extends StatelessWidget {
  const ProfileDetailsListScreen({
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
              Get.to(ZodiacScreen());
            },
            child: InterestCard(
              title: 'Zodiac Sign',
              subTitle: personal.zodiacSign!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(ReligionScreen());
            },
            child: InterestCard(
              title: 'Religion',
              subTitle: personal.religion!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(VisibilityScreen());
            },
            child: InterestCard(
              title: 'Profile Visibility',
              subTitle: preference.visibility!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(LookingScreen());
            },
            child: InterestCard(
              title: 'Looking For',
              subTitle: preference.lookingFor!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              // Get.to(HeightScreen());
            },
            child: InterestCard(
              title: 'Height',
              subTitle: basicInfo.height!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(EducationScreen());
            },
            child: InterestCard(
              title: 'Education',
              subTitle: personal.qualification!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: InkWell(
            onTap: () {
              Get.to(EducationScreen());
            },
            child: InterestCard(
              title: 'Work',
              subTitle: professional.work!.jobTitle!,
              image: AppAssets.gymAssets2,
            ),
          ),
        ),
      ],
    );
  }
}
