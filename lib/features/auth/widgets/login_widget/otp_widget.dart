import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';

class OtpWidget extends StatelessWidget {
  OtpWidget({
    super.key,
    required this.onCodeChanged,
    required this.onCompleted,
  });

  final Function(String otpCode) onCodeChanged;
  final Function(String otp) onCompleted;

  final TextEditingController _otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: _otpController,
      autoFocus: true,
      keyboardType: TextInputType.number,
      animationType: AnimationType.none,
      cursorColor: Colors.black,
      showCursor: false,
      enableActiveFill: false,
      textStyle: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(20.r),
        fieldHeight: 58.h,
        fieldWidth: 68.w,

        activeColor: AppColors.appDisableButton,
        selectedColor: AppColors.otpFieldColor,
        inactiveColor: Color(0xffCFCFCF),
        selectedFillColor: Color(0xffF6F6F6),
        borderWidth: 1,
      ),
      onTap: () {
        /// 👇 move cursor to last entered digit
        final text = _otpController.text;
        final index = text.length.clamp(0, 3);

        _otpController.selection = TextSelection.fromPosition(
          TextPosition(offset: index),
        );

        otpFocusNode.requestFocus();
      },
      onChanged: (value) {
        onCodeChanged(value);
      },

      onCompleted: (otp) {
        onCompleted(otp);
      },

      beforeTextPaste: (_) => false,
    );
  }
}
