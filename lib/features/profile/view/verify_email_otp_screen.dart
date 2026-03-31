import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_font.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/auth/widgets/login_widget/otp_widget.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/email_controller.dart';

class VerifyEmailOtpScreen extends StatefulWidget {
  const VerifyEmailOtpScreen({super.key});

  @override
  State<VerifyEmailOtpScreen> createState() => _VerifyEmailOtpScreenState();
}

class _VerifyEmailOtpScreenState extends State<VerifyEmailOtpScreen> {
  final _controller = Get.find<EmailController>();

  late String email;
  @override
  void initState() {
    super.initState();
    email = Get.arguments;
    _controller.email.value = email;
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
                CommonText.titleMedium(
                  fontType: AppFontType.mono,
                  textAlign: TextAlign.center,
                  maxLines: 2,
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
                      _controller.verifyEmailOtp(); // 👈 auto verify
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
                                _controller.verifyEmailOtp();
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
