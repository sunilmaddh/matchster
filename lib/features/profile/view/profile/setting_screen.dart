import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/widgets/dark_mode_card.dart';
import 'package:matchster/features/profile/widgets/setting_card.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final RxBool isSwitchOn = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding,
        child: Obx(
          () => AppButton(
            name: AppStrings.logout,
            onTop: () {},
            isEnable: isSwitchOn.value,
          ),
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.settings,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.titleMedium(
              AppStrings.account,
              fontWeight: FontWeight.w300,
            ),
            15.hBox,

            /// Privacy
            SettingCard(
              image: AppAssets.privacySettingAssets,
              title: AppStrings.privacySetting,
              onTop: () {},
            ),

            SizedBox(height: 20.h),

            /// Account
            SettingCard(
              image: AppAssets.accountSettingAssets,
              title: AppStrings.accountSetting,
              onTop: () {},
            ),

            20.hBox,

            /// Dark mode
            Obx(
              () => DarkModeCard(
                isSwitchOn: isSwitchOn.value,
                onChanged: (bool value) {
                  isSwitchOn.value = value;
                },
                text: AppStrings.darkMode,
              ),
            ),

            20.hBox,

            /// FAQ
            SettingCard(
              image: AppAssets.faqAssets,
              title: AppStrings.faq,
              onTop: () {},
            ),

            20.hBox,

            /// Terms
            SettingCard(
              image: AppAssets.termAssets,
              title: AppStrings.termsAndConditions,
              onTop: () {},
            ),

            20.hBox,

            /// Privacy Policy
            SettingCard(
              image: AppAssets.privacyPolicyAssets,
              title: AppStrings.privacyPolicy,
              onTop: () {},
            ),
          ],
        ),
      ),
    );
  }
}
