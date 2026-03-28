import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/onboard_build_provider.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});
  // final onboardPages = Get.arguments["pages"];
  final _onboardController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.onboardTitle,
        onTop: () {
          _onboardController.pageController.previousPage(
            duration: const Duration(milliseconds: 450),
            curve: Curves.ease,
          );
          _onboardController.updateButtonState();
          _onboardController.updateStepState();
        },
      ),
      body: OnboardPageViewBuilder(pages: OnboardHalper.listWidget),
    );
  }
}
