import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_header_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/about_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/conncet_account_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/email_verification_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_details_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_image_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_location_section.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_verification_section.dart';
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
  @override
  void onInit() {
    super.onInit();
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
              onPressed: () {
                controller.navigateTo(AppRoutes.settingScreen);
              },
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                kBottomNavigationBarHeight +
                MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: ListView(
            children: [
              ProfileHeaderSection(controller: controller),
              const ProfileImageSection(),
              const ProfileVerificationSection(),
              const EmailVerificationSection(),
              const ProfileDetailsSection(),
              const ProfileLocationSection(),
              const AboutSection(),
              20.hBox,
              Divider(color: AppColors.lightBlackBorder),
              10.hBox,
              const ConnectAccountsSection(),
              70.hBox,
            ],
          ),
        ),
      ),
    );
  }
}
