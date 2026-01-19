import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/widgets/dark_mode_card.dart';
import 'package:matchster/features/moduls/profile/widgets/setting_card.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  RxBool isSwitchOn = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding,
        child: AppButton(
          name: "Log out",
          onTop: () {},
          isEnable: isSwitchOn.value,
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Setting",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              "Account",
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
            ),
            15.hBox,
            SettingCard(
              image: AppAssets.privacySettingAssets,
              title: "Privacy Setting",
              onTop: () {},
            ),
            SizedBox(height: 20.h),
            SettingCard(
              image: AppAssets.accountSettingAssets,
              title: "Account Setting",
              onTop: () {},
            ),
            20.hBox,
            DarkModeCard(
              isSwitchOn: isSwitchOn.value,
              onChanged: (bool value) {},
              text: 'Dark Mode',
            ),
            20.hBox,
            SettingCard(image: AppAssets.faqAssets, title: "FAQ", onTop: () {}),
            20.hBox,
            SettingCard(
              image: AppAssets.termAssets,
              title: "Terms & Conditions",
              onTop: () {},
            ),
            20.hBox,
            SettingCard(
              image: AppAssets.privacyPolicyAssets,
              title: "Privacy Policy",
              onTop: () {},
            ),
          ],
        ),
      ),
    );
  }
}
