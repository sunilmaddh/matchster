import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/login/halper/login_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/devider_widget.dart';
import 'package:matchster/features/moduls/auth/widgets/login_button.dart';
import 'package:matchster/features/moduls/auth/widgets/login_field_with_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  bool isLoginWithMobileNumber = true;

  final _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(AppAssets.appLogo),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  40.hBox,
                  Obx(
                    () =>
                        _controller.isLoginWithMobile.isTrue
                            ? LoginFieldWithButton()
                            : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Image.asset(AppAssets.loginAssets),
                                ),
                                30.hBox,
                                CommonText.text(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  AppConstants.letSMatchsterPeople,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                  fontSize: 30.sp,
                                  fontFamily: "Caros",
                                ),
                                40.hBox,
                                Padding(
                                  padding: 15.horizontalPadding,
                                  child: LoginButton(
                                    name: AppConstants.continueWith,
                                    onTop: () {
                                      _controller.isLoginWithMobile.value =
                                          true;
                                    },
                                  ),
                                ),
                              ],
                            ),
                  ),

                  30.hBox,
                  DeviderWidget(),
                  30.hBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        LoginHalper().socialMediaList
                            .map(
                              (v) => Padding(
                                padding: 20.horizontalPadding,
                                child: SvgPicture.asset(v),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
