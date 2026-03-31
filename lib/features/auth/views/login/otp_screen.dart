import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_font.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/login_controller.dart';
import 'package:matchster/features/auth/widgets/login_widget/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: true,
        title: AppConstants.otpVerification,
        onTop: () {
          Get.back();
        },
      ),
      body: Stack(
        children: [
          Padding(
            padding: 20.horizontalPadding + 1.verticalPadding,
            child: Column(
              children: [
                CommonText.titleMedium(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  fontType: AppFontType.mono,
                  color: Color(0xff0C0C0C),
                  AppConstants.otpDiscription,
                ),
                45.hBox,
                Obx(
                  () => OtpWidget(
                    key: ValueKey(_controller.otpRebuildKey.value),
                    onCodeChanged: (value) {
                      _controller.isOtpEnable.value = value.length == 4;
                    },
                    onCompleted: (otp) {
                      _controller.isOtpEnable.value = true;
                      _controller.otpValue.value = otp;
                      if (_controller.isOtpEnable.isTrue) {
                        _controller.verifyOtp(
                          number: _controller.phoneNumber.value,
                          otp: _controller.otpValue.value,
                        );
                      }
                    },
                  ),
                ),
                40.hBox,
                Obx(
                  () =>
                      _controller.isLoading.isTrue
                          ? CircularProgressIndicator(color: AppColors.primary)
                          : AppButton(
                            isEnable: _controller.isOtpEnable.value,
                            name: AppConstants.verifyNumber,
                            onTop: () {
                              if (_controller.isOtpEnable.isTrue) {
                                _controller.verifyOtp(
                                  number: _controller.phoneNumber.value,
                                  otp: _controller.otpValue.value,
                                );
                              }
                            },
                          ),
                ),
                5.hBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText.titleMedium(
                      AppConstants.dontSend,
                      color: Color(0xff5A5A5A),
                    ),
                    TextButton(
                      onPressed: () {
                        _controller.isResend.value = true;
                        _controller.sendOtp(_controller.phoneNumber.value);
                      },
                      child: CommonText.titleMedium(
                        AppConstants.resend,
                        color: AppColors.otpFieldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
