import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

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
  final RxBool enableBorder; // ✅ NON-NULLABLE
  final double borderRadius;
  final void Function(String?)? onChanged;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.enableBorder, // ✅ REQUIRED
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.readOnly = false,
    this.enable = true,
    this.borderRadius = 20.0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isValid = enableBorder.value;

      return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        enabled: enable,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
          border: _border(isValid),
          enabledBorder: _border(isValid),
          focusedBorder: _border(isValid),
          disabledBorder: _border(false),
        ),
      );
    });
  }

  OutlineInputBorder _border(bool isValid) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(
        color: isValid ? AppColors.textFieldColor : AppColors.borderColor,
        width: 2,
      ),
    );
  }
}
