import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/onboard_build_provider.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Onboard",
        onTop: () {
          Get.back();
        },
      ),
      body: OnboardPageViewBuilder(pages: OnboardHalper.listWidget),
    );
  }
}
