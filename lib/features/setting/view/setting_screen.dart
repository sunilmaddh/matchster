import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/profile/widgets/dark_mode_card.dart';
import 'package:matchster/features/profile/widgets/setting_card.dart';
import 'package:matchster/features/setting/controller/setting_controller.dart';
import 'package:matchster/routes/app_routes.dart';

// ignore: must_be_immutable
class SettingScreen extends BaseStatelessView<SettingController> {
  SettingScreen({super.key});

  RxBool isSwitchOn = true.obs;
  RxBool isLoggingOut = false.obs;

  Future<void> logout() async {
    Get.delete<OnboardController>();
    MatchsterLocalStorage.instance.logout();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  Widget buildView(BuildContext context, SettingController controller) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding,
        child: Obx(() {
          final isLoading = isLoggingOut.value;
          return AppButton(
            name: AppStrings.settingString.logout,
            onTop: () {
              if (!isLoading) logout();
            },
            isEnable: !isLoading,
          );
        }),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.settingString.settingTitle,
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              AppStrings.settingString.account,
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
            ),

            SettingCard(
              color: AppColors.privacyColor,
              image: AppAssets.privacySettingAssets,
              title: AppStrings.settingString.privacySetting,
              onTop: () {},
            ),

            SettingCard(
              color: AppColors.accountColor,
              image: AppAssets.accountSettingAssets,
              title: AppStrings.settingString.accountSetting,
              onTop: () {},
            ),

            DarkModeCard(
              isSwitchOn: isSwitchOn.value,
              onChanged: (bool value) {},
              text: AppStrings.settingString.darkMode,
            ),

            DarkModeCard(
              isSwitchOn: !isSwitchOn.value,
              onChanged: (bool value) {},
              text: AppStrings.settingString.pushNotification,
            ),

            SettingCard(
              color: AppColors.faqColor,
              image: AppAssets.faqAssets,
              title: AppStrings.settingString.faq,
              onTop: () {},
            ),

            SettingCard(
              color: AppColors.termColor,
              image: AppAssets.termAssets,
              title: AppStrings.settingString.termConditions,
              onTop: () {},
            ),

            SettingCard(
              color: AppColors.privacyPolicyColor,
              image: AppAssets.privacyPolicyAssets,
              title: AppStrings.settingString.privacyPolicy,
              onTop: () {},
            ),
          ],
        ),
      ),
    );
  }
}
