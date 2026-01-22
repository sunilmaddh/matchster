import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.onCodeChanged,
    required this.onCompleted,
  });
  final Function(String otpCode) onCodeChanged;
  final Function(String otp) onCompleted;

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      textStyle: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
      borderRadius: BorderRadius.circular(20.0.r),
      fieldHeight: 62.h,
      fieldWidth: 62.w,
      fillColor: AppColors.otpFieldColor,
      filled: false,
      autoFocus: true,
      borderWidth: 1,
      keyboardType: TextInputType.number,
      numberOfFields: 4,
      margin: 10.5.horizontalPadding,
      borderColor: AppColors.otpFieldColor,
      showFieldAsBox: true,
      showCursor: false,
      onSubmit: (otp) {
        onCompleted(otp);
      },

      // Optional: partial change
      onCodeChanged: (v) {
        onCodeChanged(v);
      },
    );
  }
}
