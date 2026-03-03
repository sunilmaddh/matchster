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
import 'package:matchster/features/moduls/auth/login/widgets/login_button.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/view/location/add_home_town_screen.dart';
import 'package:matchster/features/moduls/profile/view/location/current_location.dart';
import 'package:matchster/features/moduls/profile/view/profile/profile_preview_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile/setting_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile_photo_preview_screen.dart';
import 'package:matchster/features/moduls/profile/widgets/add_image_grid_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/add_instagram_card.dart';
import 'package:matchster/features/moduls/profile/widgets/add_spotify_card.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_card.dart';
import 'package:matchster/features/moduls/profile/widgets/location_card.dart';
import 'package:matchster/features/moduls/profile/widgets/preference_list_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/profile_details_list_screen.dart';

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
          final imageCount = _controller.allPfFame.length;
          final itemCount = imageCount + 1;

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
                              fit: BoxFit.contain,
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
                                                              .basicInfo
                                                              .value
                                                              .profilePic !=
                                                          null &&
                                                      _controller
                                                              .basicInfo
                                                              .value
                                                              .profilePic
                                                              ?.url !=
                                                          null
                                                      ? CommonAssets.networkImage(
                                                        fit: BoxFit.cover,
                                                        _controller
                                                            .basicInfo
                                                            .value
                                                            .profilePic!
                                                            .url!,
                                                      )
                                                      : SizedBox(),
                                            ),
                                          ),
                                        ),
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
                                            Get.to(ProfilePreviewScreen());
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
                                      _controller.meta.value.progress!
                                          .toDouble(),
                                  onChanged: (double value) {},
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
                        // Prevent adding more than 6 images
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
                                                final context = Get.context;
                                                if (context != null &&
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).canPop()) {
                                                  Navigator.of(
                                                    context,
                                                    rootNavigator: true,
                                                  ).pop();
                                                }

                                                // 3️⃣ Give Vivo camera time to get foreground (CRITICAL)
                                                // await Future.delayed(
                                                //   const Duration(milliseconds: 300),
                                                // );

                                                // 4️⃣ Clear image cache BEFORE opening camera
                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clear();
                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clearLiveImages();

                                                File? selectedImage;

                                                // 5️⃣ Open camera/gallery WITHOUT touching UI state
                                                if (v["text"] == "Camera") {
                                                  selectedImage =
                                                      await ImageUploadServices()
                                                          .pickImageFromCamera();
                                                } else {
                                                  selectedImage =
                                                      await ImageUploadServices()
                                                          .getImageFromGallery();
                                                }

                                                // 6️⃣ NOW update UI
                                                debugPrint(
                                                  "Selected image ${selectedImage.toString()}",
                                                );
                                                if (selectedImage != null &&
                                                    selectedImage
                                                        .path
                                                        .isNotEmpty) {
                                                  // _controller.isSelectingImage(
                                                  //   true,
                                                  // ); // loader AFTER camera

                                                  Get.to(
                                                    () =>
                                                        ProfilePhotoPreviewScreen(
                                                          imageFile:
                                                              selectedImage!,
                                                        ),
                                                  );
                                                }
                                              } catch (e, s) {
                                                AppMethods.appPrint(
                                                  message: e.toString(),
                                                );
                                                debugPrintStack(stackTrace: s);
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
                        // _openImagePickerBottomSheet();
                      },
                      onTopRemove: (id) {
                        CustomBottomSheet.show(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // height: 100.h,
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
                              onTap: () {
                                // Get.to(FaceRecogonizationWidget());
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
