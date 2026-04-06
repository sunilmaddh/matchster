import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/login_controller.dart';
import 'package:matchster/features/auth/widgets/login_widgets/otp_widget.dart';

class OtpScreen extends BaseView<LoginController> {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends BaseViewState<LoginController, OtpScreen> {
  @override
  Widget buildView(BuildContext context) {
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
            _buildDescription(),
            45.hBox,
            _buildOtpField(),
            40.hBox,
            _buildVerifyButton(),
            5.hBox,
            _buildResendSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return CommonText.text(
      AppConstants.otpDiscription,
      fontFamily: 'DM Sans',
      textAlign: TextAlign.center,
      maxLines: 2,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xff0C0C0C),
    );
  }

  Widget _buildOtpField() {
    return Obx(
      () => OtpWidget(
        key: ValueKey(controller.otpRebuildKey.value),
        onCodeChanged: (value) {
          controller.isOtpEnable.value = value.length == 4;
          controller.otpValue.value = value;
        },
        onCompleted: (otp) {
          controller.otpValue.value = otp;
          controller.isOtpEnable.value = otp.length == 4;

          if (controller.isOtpEnable.value) {
            controller.verifyOtp(
              number: controller.phoneNumber.value,
              otp: controller.otpValue.value,
            );
          }
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Obx(
      () => AppButton(
        isEnable: controller.isOtpEnable.value,
        name: AppConstants.verifyNumber,
        onTop: () {
          if (!controller.isOtpEnable.value) return;

          controller.verifyOtp(
            number: controller.phoneNumber.value,
            otp: controller.otpValue.value,
          );
        },
      ),
    );
  }

  Widget _buildResendSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText.text(
          AppConstants.dontSend,
          fontSize: 16.sp,
          color: const Color(0xff5A5A5A),
          fontWeight: FontWeight.w400,
        ),
        TextButton(
          onPressed: _onResendTap,
          child: CommonText.text(
            AppConstants.resend,
            fontSize: 16.sp,
            color: AppColors.otpFieldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _onResendTap() {
    controller.isResend.value = true;
    controller.sendOtp(controller.phoneNumber.value);
  }
}
