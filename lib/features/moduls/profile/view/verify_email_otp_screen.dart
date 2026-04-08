import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/widgets/otp_widget.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

class VerifyEmailOtpScreen extends StatefulWidget {
  const VerifyEmailOtpScreen({super.key});

  @override
  State<VerifyEmailOtpScreen> createState() => _VerifyEmailOtpScreenState();
}

class _VerifyEmailOtpScreenState extends State<VerifyEmailOtpScreen> {
  final _controller = Get.find<ProfileController>();

  late String email;
  @override
  void initState() {
    super.initState();
    email = Get.arguments;
  }

  Future<void> verifyEmailOtp() async {
    if (_controller.isOtpEnable.isTrue) {
      bool result = await _controller.verifyEmailOtp(
        email: email,
        otp: _controller.otpValue.value,
      );

      if (result) {
        await _controller.getMyProfile(false);
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Get.snackbar(
          "Error",
          "OTP verification failed. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

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
                CommonText.text(
                  fontFamily: "DM Sans",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff0C0C0C),
                  AppConstants.emailOtpDiscription,
                  //  " ${AppConstants.emailOtpDiscription} ${_controller.phoneNumber.value}",
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
                      verifyEmailOtp(); // 👈 auto verify
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
                                verifyEmailOtp(); // 👈 call here
                              }
                            },
                          ),
                ),
                5.hBox,
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
                      onPressed: () {
                        _controller.isResend.value = true;
                      },
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
          // Obx(
          //   () =>
          //       _controller.isResend.isTrue
          //           ? Align(
          //             alignment: Alignment.center,
          //             child: CircularProgressIndicator(
          //               color: AppColors.primary,
          //             ),
          //           )
          //           : SizedBox.shrink(),
          // ),
        ],
      ),
    );
  }
}
