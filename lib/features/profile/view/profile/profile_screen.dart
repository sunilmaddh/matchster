import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/login_widget/login_button.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/home/controller/location_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/add_image_grid_widget.dart';
import 'package:matchster/features/profile/widgets/add_instagram_card.dart';
import 'package:matchster/features/profile/widgets/add_spotify_card.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/features/profile/widgets/location_card.dart';
import 'package:matchster/features/profile/widgets/preference_list_widget.dart';
import 'package:matchster/features/profile/widgets/profile_details_list_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileScreen extends BaseView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  bool get useDefaultLoader => false;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends BaseViewState<ProfileController, ProfileScreen> {
  late final ProfileFormController _formController;
  late final LocationController _locationController;

  @override
  void onInit() {
    super.onInit();
    _formController = Get.find<ProfileFormController>();
    _locationController = Get.find<LocationController>();
    controller.getMyProfile();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        isLeading: false,
        title: AppStrings.profile,
        onTop: Get.back,
        actions: [
          Padding(
            padding: 15.horizontalPadding,
            child: TextButton(
              onPressed: () {},
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          // if (controller.isProfileLoading.isTrue) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          return Padding(
            padding: EdgeInsets.only(
              bottom:
                  kBottomNavigationBarHeight +
                  MediaQuery.viewPaddingOf(context).bottom,
            ),
            child: ListView(
              children: [
                _buildHeaderSection(),
                _buildImageSection(context),
                _buildVerificationSection(),
                _buildDetailsSection(),
                _buildLocationSection(),
                _buildAboutSection(),
                20.hBox,
                Divider(color: AppColors.lightBlackBorder),
                10.hBox,
                _buildConnectAccountsSection(),
                70.hBox,
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
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
                          borderRadius: BorderRadius.circular(100.r),
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            height: 69.h,
                            width: 69.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.profileBadgeBorder,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child:
                                  controller.basicInfo?.profilePic != null
                                      ? CommonAssets.networkImage(
                                        controller.basicInfo?.profilePic!.url ??
                                            "",
                                      )
                                      : const SizedBox.shrink(),
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
                        Obx(
                          () => Row(
                            children: [
                              CommonText.text(
                                "${controller.basicInfo?.name}, ${controller.basicInfo?.age}",
                                fontSize: 16.sp,

                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                              ),
                              10.wBox,
                              SvgPicture.asset(AppAssets.verified),
                            ],
                          ),
                        ),
                        5.hBox,
                        InkWell(
                          onTap: () {
                            controller.navigateTo(
                              AppRoutes.profilePreviewScreen,
                            );
                          },
                          child: Container(
                            padding: 15.horizontalPadding + 2.verticalPadding,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppColors.previewBorder,
                              ),
                            ),
                            child: CommonText.text(
                              AppStrings.preview,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor.withAlpha(153),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                15.hBox,
                LinearProgressBarWithBadge(
                  value: controller.meta?.progress?.toDouble() ?? 0,
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return AddImageGrid(
      imageList: controller.hallOfFames,
      onTop: (_) => _showImagePickerSheet(),
      onTopRemove: (id) => _showRemoveImageSheet(context, id),
    );
  }

  Widget _buildVerificationSection() {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppStrings.verifyYourProfile,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          5.hBox,
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: InkWell(
              onTap: () => controller.navigateTo(AppRoutes.faceCamera),
              child: InterestCard(
                color: AppColors.verifiedCardColor,
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

  Widget _buildDetailsSection() {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreferenceListWidget(
            lifestyle: controller.lifestyle ?? Lifestyle(),
            personal: controller.personal ?? Personal(),
          ),
          10.hBox,
          ProfileDetailsListScreen(
            personal: controller.personal ?? Personal(),
            preference: controller.preferences ?? Preferences(),
            professional: controller.professional ?? Professional(),
            basicInfo: controller.basicInfo ?? BasicInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    final currentAddress = controller.currentLocation?.address?.label ?? '';
    final homeData = controller.homeTown;

    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.text(
            AppStrings.location,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          5.hBox,
          InkWell(
            onTap: () => controller.navigateTo(AppRoutes.currentLocationScreen),
            child: LocationCard(
              title: AppStrings.currentLocation,
              subTitle: currentAddress,
            ),
          ),
          15.hBox,
          InkWell(
            onTap: () {
              _locationController.cityController.text = homeData?.city ?? '';
              _locationController.selectedState.value = homeData?.state ?? '';
              controller.navigateTo(AppRoutes.addHomeTownScreen);
            },
            child: LocationCard(
              title: AppStrings.homeTown,
              subTitle: _formatHomeTown(
                city: homeData?.city,
                state: homeData?.state,
                country: homeData?.country,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    _formController.aboutController.text = controller.bio?.about ?? '';

    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.text(
            AppStrings.makeItShortAndFunky,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Caros",
          ),
          5.hBox,
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightBlackBorder),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: 10.horizontalPadding + 5.verticalPadding,
              child: TextFormField(
                controller: _formController.aboutController,
                decoration: InputDecoration(
                  hint: CommonText.text(
                    AppStrings.aboutHint,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.aboutHintColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (about) {
                  _formController.isAboutEnable.value = about.trim().isNotEmpty;
                },
              ),
            ),
          ),
          Obx(
            () =>
                _formController.isAboutEnable.isTrue
                    ? Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: AppButton(
                        isEnable: true,
                        name: AppStrings.save,
                        onTop: () {
                          controller.addAbout(
                            _formController.aboutController.text.trim(),
                          );
                        },
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectAccountsSection() {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppStrings.connectAccounts,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          CommonText.text(
            AppStrings.buildYourConnectionMore,
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
          5.hBox,
          AddInstagramCard(),
          30.hBox,
          AddSpotifyCard(),
        ],
      ),
    );
  }

  Future<void> _showImagePickerSheet() async {
    await CustomBottomSheet.show(
      borderRadius: 40.r,
      backgroundColor: AppColors.sheetBackground,
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
                    OnboardHalper.addPhotoOption.map((option) {
                      return InkWell(
                        onTap: () => _pickImage(option["text"] ?? ''),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(option["image"] ?? ''),
                            CommonText.text(
                              option["text"] ?? '',
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
                AppStrings.cancel,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(String source) async {
    try {
      final context = Get.context;
      if (context != null &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      File? selectedImage;

      if (source == AppStrings.camera) {
        selectedImage = await ImageUploadServices().pickImageFromCamera();
      } else {
        selectedImage = await ImageUploadServices().getImageFromGallery();
      }

      if (selectedImage != null && selectedImage.path.isNotEmpty) {
        Get.to(() => (imageFile: selectedImage!));
      }
    } catch (e, s) {
      AppMethods.appPrint(message: e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> _showRemoveImageSheet(BuildContext context, String id) async {
    await CustomBottomSheet.show(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              isEnable: true,
              name: AppStrings.remove,
              onTop: () {
                controller.deleteProfile(profileId: id);
              },
            ),
            20.hBox,
            LoginButton(name: AppStrings.cancel, onTop: Get.back),
          ],
        ),
      ),
    );
  }

  String _formatHomeTown({
    required String? city,
    required String? state,
    required String? country,
  }) {
    final values =
        [city, state, country]
            .where((e) => e != null && e.trim().isNotEmpty)
            .map((e) => e!.capitalize!)
            .toList();

    return values.join(', ');
  }
}
