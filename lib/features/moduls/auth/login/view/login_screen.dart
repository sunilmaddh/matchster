import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/login/widgets/login_button.dart';
import 'package:matchster/features/moduls/auth/login/widgets/login_field_with_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  bool isLoginWithMobileNumber = true;
  final RxBool isEnable = false.obs;

  final _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () =>
            _controller.isLoginWithMobile.isTrue
                ? Padding(
                  padding: 20.horizontalPadding,
                  child: AppButton(
                    isEnable: _controller.isEnable.value,
                    name: AppConstants.verify,
                    onTop: () async {
                      final number =
                          _controller.countryCode + _controller.controller.text;

                      _controller.phoneNumber.value = number;

                      await _controller.sendOtp(number);
                      // NavigationHelper.push(OtpScreen());
                    },
                  ),
                )
                : SizedBox.shrink(),
      ),
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
                  30.hBox,
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
                                Padding(
                                  padding: 15.horizontalPadding,
                                  child: CommonText.text(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    AppConstants.discoverSolumates,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackColor,
                                    fontSize: 28.sp,
                                    fontFamily: "Caros",
                                  ),
                                ),
                                _controller.isAccessMyAccount.isTrue
                                    ? 10.hBox
                                    : 30.hBox,
                                _controller.isAccessMyAccount.isTrue
                                    ? Padding(
                                      padding: 28.horizontalPadding,
                                      child: Column(
                                        children: [
                                          LoginButton(
                                            image: AppAssets.instagramAssets,
                                            name: AppConstants.instagram,
                                            onTop: () {
                                              // _controller
                                              //     .isLoginWithMobile
                                              //     .value = true;
                                            },
                                          ),
                                          10.hBox,
                                          LoginButton(
                                            image: AppAssets.facebookAssets,
                                            name: AppConstants.facebook,
                                            onTop: () {
                                              _controller
                                                  .isLoginWithMobile
                                                  .value = true;
                                            },
                                          ),
                                          10.hBox,
                                          LoginButton(
                                            image: AppAssets.googleAssets,
                                            name: AppConstants.google,
                                            onTop: () async {
                                              _controller.signWithGoogle();
                                              // _controller
                                              //     .isLoginWithMobile
                                              //     .value = true;
                                            },
                                          ),
                                          10.hBox,
                                          AppButton(
                                            image: AppAssets.contactAssets,
                                            isEnable: true,
                                            name: AppConstants.number,
                                            onTop: () {
                                              _controller
                                                  .isLoginWithMobile
                                                  .value = true;
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                    : Padding(
                                      padding: 28.horizontalPadding,
                                      child: Column(
                                        children: [
                                          AppButton(
                                            isEnable: true,
                                            name: AppConstants.createMyAccount,
                                            onTop: () {
                                              _controller
                                                  .isLoginWithMobile
                                                  .value = true;
                                            },
                                          ),
                                          10.hBox,
                                          LoginButton(
                                            name: AppConstants.accessMyAccount,
                                            onTop: () {
                                              _controller
                                                  .isAccessMyAccount
                                                  .value = true;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                              ],
                            ),
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
