import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/login/widgets/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppConstants.otpVerification,
        onTop: () {},
      ),
      body: Padding(
        padding: 20.horizontalPadding + 10.verticalPadding,
        child: Column(
          children: [
            CommonText.text(
              textAlign: TextAlign.center,
              maxLines: 2,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff0C0C0C),
              " AppConstants.otpDiscription ${_controller.phoneNumber.value}",
            ),
            40.hBox,
            OtpWidget(
              onCodeChanged: (value) {
                _controller.isOtpEnable.value = value.length == 4;
              },
              onCompleted: (otp) {
                _controller.isOtpEnable.value = true;
                _controller.otpValue.value = otp;
              },
            ),
            32.hBox,
            Obx(
              () =>
                  _controller.isLoading.isTrue
                      ? CircularProgressIndicator(color: AppColors.primary)
                      : AppButton(
                        isEnable: _controller.isOtpEnable.value,
                        name: AppConstants.verifyNumber,
                        onTop: () {
                          _controller.verifyOtp(
                            number: _controller.phoneNumber.value,
                            otp: _controller.otpValue.value,
                          );
                        },
                      ),
            ),
            10.hBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText.text(
                  AppConstants.dontSend,
                  fontSize: 16.sp,
                  color: Color(0xff5A5A5A),
                  fontWeight: FontWeight.w400,
                ),
                TextButton(
                  onPressed: () {},
                  child: CommonText.text(
                    AppConstants.resend,
                    fontSize: 16.sp,
                    color: AppColors.otpFieldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
