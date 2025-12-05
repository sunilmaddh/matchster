import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key, required this.onCodeChanged});
  final Function(String otpCode) onCodeChanged;

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      textStyle: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
      borderRadius: BorderRadius.circular(20.0.r),
      fieldHeight: 58,
      fieldWidth: 68,
      fillColor: AppColors.otpFieldColor,
      filled: false,
      autoFocus: true,
      borderWidth: 1,
      numberOfFields: 4,
      margin: 10.5.horizontalPadding,
      borderColor: AppColors.otpFieldColor,
      showFieldAsBox: true,
      showCursor: false,
      onCodeChanged: onCodeChanged,
      onSubmit: (String verificationCode) {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: Text("Verification Code"),
        //       content: Text('Code entered is $verificationCode'),
        //     );
        //   },
        // );
      }, // end onSubmit
    );
  }
}
