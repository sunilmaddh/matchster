import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/onboard_widgets/onboard_build_provider.dart';

class OnboardScreen extends BaseStatelessView<OnboardController> {
  OnboardScreen({super.key});
  // final onboardPages = Get.arguments["pages"];
  final _onboardController = Get.find<OnboardController>();

  @override
  Widget buildView(BuildContext context, OnboardController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.onboard,
        onTop: () {
          _onboardController.pageController.previousPage(
            duration: const Duration(milliseconds: 450),
            curve: Curves.ease,
          );
          _onboardController.updateButtonState();
          _onboardController.updateStepState();
          // _onboardController.isEnable.value = true;
        },
      ),
      body: OnboardPageViewBuilder(pages: OnboardHalper.listWidget),
    );
  }
}
