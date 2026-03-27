import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/modules/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/modules/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/modules/auth/widgets/onboard_widget/onboard_build_provider.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});
  // final onboardPages = Get.arguments["pages"];
  final _onboardController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Onboard",
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
