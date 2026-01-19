import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';

class CurrentLoadingScreen extends StatelessWidget {
  CurrentLoadingScreen({super.key});

  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    _controller.onboardingCompleted();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonAssets.svgAsset(AppAssets.appLogo),
            100.hBox,
            SizedBox(
              width: 50.w,
              height: 50.h,
              child: CupertinoActivityIndicator(radius: 40.r),
            ),
            30.hBox,
            CommonText.text(
              "Please wait we are getting location",
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}
