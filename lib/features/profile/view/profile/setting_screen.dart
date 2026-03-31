import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/setting_controller.dart';
import 'package:matchster/features/profile/widgets/dark_mode_card.dart';
import 'package:matchster/features/profile/widgets/setting_card.dart';
import 'package:matchster/routes/app_navigation.dart';

// ignore: must_be_immutable
class SettingScreen extends BaseStatelessView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget buildView(BuildContext context, SettingController controller) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding,
        child: Obx(() {
          final isLoading = controller.isLoggingOut.value;
          return AppButton(
            name: isLoading ? "Logging out..." : "Log out",
            onTop: () {
              if (!isLoading) controller.logout();
            },
            isEnable: !isLoading,
          );
        }),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Setting",
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.titleMedium("Account", fontWeight: FontWeight.w300),
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
              isSwitchOn: false,
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
