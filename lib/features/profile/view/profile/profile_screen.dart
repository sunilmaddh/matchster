import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/widgets/login_widgets/login_button.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/location/add_home_town_screen.dart';
import 'package:matchster/features/profile/view/location/current_location.dart';
import 'package:matchster/features/profile/view/profile/profile_preview_screen.dart';
import 'package:matchster/features/profile/view/profile/setting_screen.dart';
import 'package:matchster/features/profile/view/profile_photo_preview_screen.dart';
import 'package:matchster/features/profile/view/verify_email_screen.dart';
import 'package:matchster/features/profile/widgets/add_image_grid_widget.dart';
import 'package:matchster/features/profile/widgets/add_instagram_card.dart';
import 'package:matchster/features/profile/widgets/add_spotify_card.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/features/profile/widgets/location_card.dart';
import 'package:matchster/features/profile/widgets/preference_list_widget.dart';
import 'package:matchster/features/profile/widgets/profile_details_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = Get.find<ProfileController>();

  @override
  void initState() {
    _controller.getMyProfile(true);
    super.initState();
  }

  void _showProfileImageUploadOptions() {
    CustomBottomSheet.show(
      borderRadius: 40.r,
      backgroundColor: const Color(0xffF4F4F4),
      padding: EdgeInsets.zero,
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
                          try {
                            Get.back();
                            File? selectedImage;

                            if (v["text"] == "Camera") {
                              final file =
                                  await ImageUploadServices()
                                      .pickImageFromCamera();
                              if (file != null) {
                                selectedImage = file;
                              }
                            } else {
                              final file =
                                  await ImageUploadServices()
                                      .pickImageFromGallery();
                              if (file != null) {
                                selectedImage = file;
                              }
                            }
                            if (selectedImage != null &&
                                selectedImage.path.isNotEmpty) {
                              await _uploadProfileImage(selectedImage);
                            }
                          } catch (e) {
                            AppMethods.appPrint(message: e.toString());
                          }
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
              onPressed: Get.back,
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
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    try {
      AppToastMessage.show(title: "Uploading", message: "Please wait...");

      // Step 1: Upload image file to get URL
      final uploadResponse = await _controller.profileServices
          .uploadImageWithDio(imageFile.path);

      if (uploadResponse == null || !uploadResponse.success) {
        AppToastMessage.show(
          title: "Error",
          message: "Failed to upload image",
          isError: true,
        );
        return;
      }

      final imageUrl = uploadResponse.data?.url;
      if (imageUrl == null || imageUrl.isEmpty) {
        AppToastMessage.show(
          title: "Error",
          message: "Invalid image URL received",
          isError: true,
        );
        return;
      }

      // Step 2: Set profile image with URL
      final success = await _controller.addProfileImage(url: imageUrl);

      if (success) {
        AppToastMessage.show(
          title: "Success",
          message: "Profile image updated",
        );
        await _controller.getMyProfile(false);
      } else {
        AppToastMessage.show(
          title: "Error",
          message: "Failed to set profile image",
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      AppToastMessage.show(
        title: "Error",
        message: "An error occurred",
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        isLeading: false,
        title: "Profile",
        onTop: () {
          Get.back();
        },
        actions: [
          Padding(
            padding: 15.horizontalPadding,
            child: TextButton(
              onPressed: () {
                Get.to(() => SettingScreen());
              },
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
            // IconButton(
            //   onPressed: () {
            //     // Get.to<SettingScreen>();
            //   },
            //   icon: Icon(Icons.settings_outlined),
            // ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return _controller.isProfileLoading.isTrue
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.only(
                  bottom:
                      kBottomNavigationBarHeight +
                      MediaQuery.viewPaddingOf(context).bottom,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: 10.horizontalPadding,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Image.asset(
                                AppAssets.profileHeader,
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            100.r,
                                          ),
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
                                              child:
                                                  _controller
                                                              .allPfFame
                                                              .isNotEmpty &&
                                                          _controller
                                                                  .allPfFame[0]
                                                                  .url !=
                                                              null
                                                      ? CommonAssets.networkImage(
                                                        fit: BoxFit.cover,
                                                        _controller
                                                            .allPfFame[0]
                                                            .url!,
                                                      )
                                                      : Container(
                                                        color: Color(
                                                          0xffF0F0F0,
                                                        ),
                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                            ),
                                          ),
                                        ),
                                        // Positioned(
                                        //   right: 0,
                                        //   bottom: 0,
                                        //   child: CircleAvatar(
                                        //     backgroundColor:
                                        //         AppColors.whiteColor,
                                        //     radius: 12,
                                        //     child: Icon(
                                        //       Icons.edit,
                                        //       color: AppColors.primary,
                                        //       size: 10.sp,
                                        //     ),
                                        //   ),
                                        // ),
                                        Positioned(
                                          right: 1,
                                          top: -3,
                                          child: SvgPicture.asset(
                                            AppAssets.badge,
                                          ),
                                        ),
                                      ],
                                    ),
                                    20.wBox,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CommonText.text(
                                                "${_controller.basicInfo.value.name}, ${_controller.basicInfo.value.age}",
                                                fontSize: 16.sp,
                                                fontFamily: "Caros",
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.whiteColor,
                                              ),
                                              10.wBox,
                                              SvgPicture.asset(
                                                AppAssets.verified,
                                              ),
                                            ],
                                          ),
                                        ),
                                        5.hBox,
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => ProfilePreviewScreen(),
                                            );
                                          },
                                          child: Container(
                                            padding:
                                                15.horizontalPadding +
                                                2.verticalPadding,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xffDEDEDE),
                                              ),
                                            ),
                                            child: CommonText.text(
                                              "Preview",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff666666),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                15.hBox,
                                LinearProgressBarWithBadge(
                                  value:
                                      (_controller.meta.value.progress
                                              ?.toDouble() ??
                                          0.0),
                                  onChanged: (double value) {},
                                ),
                                5.hBox,
                                if ((_controller.meta.value.progress
                                            ?.toDouble() ??
                                        0.0) <
                                    100)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.whiteColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 5.h,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          padding: EdgeInsets.all(5.r),
                                          child: Image.asset(
                                            AppAssets.userBadge,
                                            height: 14.h,
                                            width: 14.w,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: CommonText.text(
                                            "Complete your profile so that we can find better matches for you!",
                                            maxLines: 2,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AddImageGrid(
                      imageList: _controller.allPfFame,
                      onTop: (index) {
                        if (_controller.allPfFame.length >= 6) {
                          AppToastMessage.show(
                            title: "Limit Reached",
                            message: "You can only upload up to 6 photos",
                            isError: true,
                          );
                          return;
                        }
                        CustomBottomSheet.show(
                          borderRadius: 40.r,
                          backgroundColor: const Color(0xffF4F4F4),
                          padding: EdgeInsets.zero,
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      15.horizontalPadding + 30.verticalPadding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children:
                                        OnboardHalper.addPhotoOption.map((v) {
                                          return InkWell(
                                            onTap: () async {
                                              try {
                                                Get.back();

                                                File? selectedImage;

                                                if (v["text"] == "Camera") {
                                                  final file =
                                                      await ImageUploadServices()
                                                          .pickImageFromCamera();
                                                  if (file != null) {
                                                    selectedImage = file;
                                                  }
                                                } else {
                                                  final files =
                                                      await ImageUploadServices()
                                                          .pickImagesFromGallery();

                                                  if (files != null &&
                                                      files.isNotEmpty) {
                                                    final remaining =
                                                        6 -
                                                        _controller
                                                            .allPfFame
                                                            .length;

                                                    final selectedFiles =
                                                        files
                                                            .take(remaining)
                                                            .toList();

                                                    await _controller
                                                        .processSelectedFiles(
                                                          selectedFiles,
                                                        );

                                                    // for (var file
                                                    //     in selectedFiles) {
                                                    //   await Get.to(
                                                    //     () =>
                                                    //         ProfilePhotoPreviewScreen(
                                                    //           imageFile: file,
                                                    //           imageIndex: index,
                                                    //         ),
                                                    //   );
                                                    // }
                                                  }
                                                }
                                                if (selectedImage != null &&
                                                    selectedImage
                                                        .path
                                                        .isNotEmpty) {
                                                  await Get.to(
                                                    () =>
                                                        ProfilePhotoPreviewScreen(
                                                          imageFile:
                                                              selectedImage!,
                                                          imageIndex: index,
                                                        ),
                                                  );
                                                }
                                              } catch (e) {
                                                AppMethods.appPrint(
                                                  message: e.toString(),
                                                );
                                              }
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
                                  onPressed: Get.back,
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
                      onTopRemove: (id) {
                        CustomBottomSheet.show(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppButton(
                                  isEnable: true,
                                  name: "Remove",
                                  onTop: () {
                                    _controller.deleteProfile(profileId: id);
                                  },
                                ),
                                20.hBox,
                                LoginButton(
                                  name: "Cancel",
                                  onTop: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onSwap: (position1, position2) {
                        _controller.swapFames(
                          position1: position1,
                          position2: position2,
                        );
                      },
                    ),
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
                              onTap: () {},
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
                          5.hBox,
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: InkWell(
                              onTap: () {
                                if ((_controller.basicInfo.value.email ==
                                        null ||
                                    _controller
                                        .basicInfo
                                        .value
                                        .email!
                                        .isEmpty)) {
                                  Get.to(() => VerifyEmailScreen());
                                }
                              },
                              child: InterestCard(
                                showBackArrow:
                                    (_controller.basicInfo.value.email ==
                                                null ||
                                            _controller
                                                .basicInfo
                                                .value
                                                .email!
                                                .isEmpty)
                                        ? true
                                        : false,
                                color: Color(0xff1D48EF),
                                title:
                                    (_controller.basicInfo.value.email ==
                                                null ||
                                            _controller
                                                .basicInfo
                                                .value
                                                .email!
                                                .isEmpty)
                                        ? "Verify Email"
                                        : "Email Verified",

                                subTitle:
                                    (_controller.basicInfo.value.email ==
                                                null ||
                                            _controller
                                                .basicInfo
                                                .value
                                                .email!
                                                .isEmpty)
                                        ? 'Confirm It’s Really You'
                                        : 'Your email is verified',
                                // image: AppAssets.verifyEmailIcon,
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
                          PreferenceListWidget(
                            lifestyle: _controller.lifestyle.value,
                            personal: _controller.personal.value,
                          ),

                          10.hBox,
                          ProfileDetailsListScreen(
                            personal: _controller.personal.value,
                            preference: _controller.prefeence.value,
                            professional: _controller.professional.value,
                            basicInfo: _controller.basicInfo.value,
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
                              Get.to(() => CurrentLocation());
                            },
                            child: LocationCard(
                              title: "Current Location",
                              subTitle:
                                  _controller.currentLocations.value.address !=
                                          null
                                      ? _controller
                                          .currentLocations
                                          .value
                                          .address!
                                          .label!
                                      : "",
                            ),
                          ),
                          15.hBox,
                          InkWell(
                            onTap: () {
                              final data = _controller.hometLocations.value;

                              if (data.city != null && data.city!.isNotEmpty) {
                                _controller.cityController.text = data.city!;
                                _controller.selectedState.value = data.state!;
                              } else {
                                _controller.cityController.text = "";
                                _controller.selectedState.value = "";
                              }
                              Get.to(() => AddHomeTownScreen());
                            },
                            child: LocationCard(
                              title: "Home Town",
                              subTitle:
                                  _controller.hometLocations.value.city != null
                                      ? "${_controller.hometLocations.value.city!.capitalize} ${_controller.hometLocations.value.state!} ${_controller.hometLocations.value.country!}"
                                      : "",
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
                              border: Border.all(
                                color: Colors.black.withAlpha(51),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: 10.horizontalPadding + 5.verticalPadding,
                              child: TextFormField(
                                controller: _controller.aboutController,
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
                                onChanged: (about) {
                                  // ignore: unnecessary_null_comparison
                                  if (about != null && about.isNotEmpty) {
                                    _controller.isAboutEnable.value = true;
                                  } else {
                                    _controller.isAboutEnable.value = false;
                                  }
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () =>
                                _controller.isAboutEnable.isTrue
                                    ? Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: AppButton(
                                        isEnable:
                                            _controller.isAboutEnable.isTrue,
                                        name: "Save",
                                        onTop: () {
                                          _controller.addAout(
                                            about:
                                                _controller
                                                    .aboutController
                                                    .text,
                                          );
                                        },
                                      ),
                                    )
                                    : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                    20.hBox,
                    Divider(color: Colors.black.withAlpha(51)),
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
                    70.hBox,
                  ],
                ),
              );
        }),
      ),
    );
  }
}
