import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/about_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/conncet_account_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_details_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_email_verification.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_header_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_image_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_location_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_verofication_section.dart';
import 'package:matchster/routes/app_routes.dart';

// ignore: must_be_immutable
class ProfileScreen extends BaseView<ProfileController> {
  ProfileScreen({super.key});

  @override
  void onInit(ProfileController controller) {
    controller.getMyProfile(true);
    super.onInit(controller);
  }

  @override
  Widget body(BuildContext context) {
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
              onPressed: () {
                controller.navigateTo(AppRoutes.setting);
              },
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isProfileLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom:
                  kBottomNavigationBarHeight +
                  MediaQuery.viewPaddingOf(context).bottom,
            ),
            child: ListView(
              children: [
                ProfileHeaderSection(controller: controller),
                ProfileImageSection(controller: controller),
                ProfileVerificationSection(controller: controller),
                EmailVerificationSection(controller: controller),
                ProfileDetailsSection(controller: controller),
                ProfileLocationSection(controller: controller),
                AboutSection(controller: controller),
                20.hBox,
                Divider(color: Colors.black.withAlpha(51)),
                10.hBox,
                const ConnectAccountsSection(),
                70.hBox,
              ],
            ),
          );
        }),
      ),
    );
  }
}
