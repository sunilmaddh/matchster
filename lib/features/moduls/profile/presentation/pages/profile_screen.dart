import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/onboard/view/face_recognisation.dart';
import 'package:matchster/features/moduls/profile/presentation/controllers/profile_controller.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/alcohal_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/interest_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/looking_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/religion_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/smoke_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/visibility_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/workout_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/interest/zodiac_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/location/current_location.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/profile/education_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/profile/height_screen.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/add_image_grid_widget.dart';
import 'package:matchster/shared/widgets/bar/custom_app_bar.dart';
import 'package:matchster/shared/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/shared/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/add_instagram_card.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/add_spotify_card.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/interest_card.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/location_card.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        onTop: () {
          Get.back();
        },
      ),
      body: ListView(
        children: [
          Padding(
            padding: 15.horizontalPadding,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    AppAssets.profileHeader,
                    width: double.infinity,
                    height: 145.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  padding: EdgeInsets.all(2.r),
                                  height: 69.h,
                                  width: 69.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xffE6D534),
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      height: 69.h,
                                      width: 69.w,
                                      AppAssets.posture1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                top: -3,
                                child: SvgPicture.asset(AppAssets.badge),
                              ),
                            ],
                          ),
                          20.wBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  CommonText.text(
                                    "Role, 28",
                                    fontSize: 16.sp,
                                    fontFamily: "Caros",
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteColor,
                                  ),
                                  10.wBox,

                                  SvgPicture.asset(AppAssets.verified),
                                ],
                              ),
                              5.hBox,
                              Container(
                                padding:
                                    15.horizontalPadding + 2.verticalPadding,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffDEDEDE)),
                                ),
                                child: CommonText.text(
                                  "Preview Profile",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffBFBFBF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      LinearProgressBarWithBadge(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          AddImageGrid(
            imageList: _controller.images,
            onTop: () {
              CustomBottomSheet.show(
                borderRadius: 40.r,
                backgroundColor: const Color(0xffF4F4F4),
                padding: EdgeInsets.zero,
                context: context,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: 15.horizontalPadding + 30.verticalPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                              OnboardHalper.addPhotoOption.map((v) {
                                return InkWell(
                                  onTap: () async {
                                    File? selectedImage;

                                    if (v["text"] == "Camera") {
                                      selectedImage =
                                          await ImageUploadServices()
                                              .getImageFromCamera();
                                    } else if (v["text"] == "File") {
                                      selectedImage =
                                          await ImageUploadServices()
                                              .getImageFromGallery();
                                    }

                                    if (selectedImage != null) {
                                      _controller.images.add(selectedImage);
                                    }
                                    Get.back();
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(v["image"]),
                                      CommonText.text(
                                        v["text"],
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      const Divider(height: 1),
                      10.hBox,
                      TextButton(
                        onPressed: () => Get.back(),
                        child: CommonText.text(
                          "Cancel",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onTopRemove: (index) {
              // _controller.images.removeAt(index);
            },
          ),

          // GridView.builder(
          //   padding: 10.horizontalPadding,
          //   shrinkWrap: true,
          //   itemCount: 6,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     mainAxisSpacing: 12,
          //     crossAxisSpacing: 12,
          //   ),
          //   itemBuilder: (BuildContext context, int index) {
          //     return ProfilePhotoCard();
          //   },
          // ),
          // 20.hBox,
          Padding(
            padding: 15.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Verify your profile",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(FaceRecogonizationWidget());
                    },
                    child: InterestCard(
                      color: Color(0xff1D48EF),
                      title: "Get Verified",
                      subTitle: 'Show others you’re real',
                      image: AppAssets.verified2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: 15.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Interests",
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
                      subTitle: 'Sometime',
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
                      subTitle: 'Sometime',
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
                      subTitle: 'Sometime',
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
                      subTitle: 'Sometime',
                      image: AppAssets.gymAssets2,
                    ),
                  ),
                ),

                10.hBox,
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
                      subTitle: 'Cancer',
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
                      subTitle: 'Hindu',
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
                      subTitle: 'Everyone',
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
                      subTitle: 'Friendship',
                      image: AppAssets.gymAssets2,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(HeightScreen());
                    },
                    child: InterestCard(
                      title: 'Height',
                      subTitle: '6.6, 187.96cms',
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
                      subTitle: 'Bachelors',
                      image: AppAssets.gymAssets2,
                    ),
                  ),
                ),

                10.hBox,

                CommonText.text(
                  "Location",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                InkWell(
                  onTap: () {
                    Get.to(CurrentLocation());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: LocationCard(),
                  ),
                ),

                10.hBox,
                CommonText.text(
                  "Make it short & funky",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.20)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: 10.horizontalPadding + 5.verticalPadding,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hint: CommonText.text(
                          "a little bit about yourself...",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff898A8D),
                        ),
                        border: InputBorder.none,
                      ),
                      showCursor: false,
                    ),
                  ),
                ),
              ],
            ),
          ),

          20.hBox,
          Divider(color: Colors.black.withOpacity(0.20)),
          10.hBox,
          Padding(
            padding: 15.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Connect Accounts",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Caros",
                ),
                CommonText.text(
                  "build your connection more",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Caros",
                ),
                5.hBox,
                AddInstagramCard(),
                30.hBox,
                AddSpotifyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
