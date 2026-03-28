import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool readOnly;
  final bool enable;
  final int maxLength;
  final RxBool enableBorder;
  final double borderRadius;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String?)? onChanged;

  CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.enableBorder,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.readOnly = false,
    this.enable = true,
    this.maxLength = 200,
    this.borderRadius = 20.0,
    this.onChanged,
    this.inputFormatters = const [], // ✅ FIX
  });

  // final FocusNode _focusNode = FocusNode();
  // final RxBool _isFocused = false.obs;

  @override
  Widget build(BuildContext context) {
    // _focusNode.addListener(() {
    //   _isFocused.value = _focusNode.hasFocus;
    // });

    return Obx(() {
      final bool isValid = enableBorder.value;

      return TextFormField(
        showCursor: true,
        enableInteractiveSelection: true,
        // focusNode: _focusNode,
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        enabled: enable,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters, // ✅ FIX
        decoration: InputDecoration(
          counterText: '',
          // labelText: !_isFocused.value && !isValid ? label : null,
          hintText: hint,
          labelStyle: TextStyle(
            fontFamily: "Caros",
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor.withAlpha(128),
          ),
          hintStyle: TextStyle(
            fontFamily: "Caros",
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor.withAlpha(128),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
          enabledBorder: _border(isValid),
          border: _border(isValid),
          focusedBorder: _border(true),
          disabledBorder: _border(false),
        ),
      );
    });
  }

  OutlineInputBorder _border(bool isValid) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(
        color:
            isValid
                ? AppColors.textFieldColor
                : AppColors.blackColor.withAlpha(64),
        width: 2,
      ),
    );
  }
}
