import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/widgets/login_widgets/otp_widget.dart';
import 'package:matchster/features/profile/controller/profile_email_controller.dart';

class VerifyEmailOtpScreen extends BaseView<ProfileEmailController> {
  VerifyEmailOtpScreen({super.key});

  @override
  void onInit(ProfileEmailController controller) {
    controller.setEmail(Get.arguments);
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: true,
        title: AppConstants.otpVerification,
        onTop: controller.navigateBack,
      ),
      body: Padding(
        padding: 20.horizontalPadding + 1.verticalPadding,
        child: Column(
          children: [
            CommonText.text(
              AppConstants.emailOtpDiscription,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff0C0C0C),
            ),
            45.hBox,
            Obx(
              () => OtpWidget(
                key: ValueKey(controller.otpRebuildKey.value),
                onCodeChanged: controller.onOtpChanged,
                onCompleted: controller.onOtpCompleted,
              ),
            ),
            40.hBox,
            Obx(
              () => AppButton(
                isEnable: controller.isOtpEnable.value,
                name: AppConstants.verifyNumber,
                onTop: controller.verifyEmailOtp,
              ),
            ),
            5.hBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText.text(
                  AppConstants.dontSend,
                  fontSize: 16.sp,
                  color: const Color(0xff5A5A5A),
                  fontWeight: FontWeight.w400,
                ),
                TextButton(
                  onPressed: controller.onResendTap,
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
