import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extensions.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color borderColor;
  final bool readOnly;
  final bool enable;
  final double borderRadius;
  // RxBool isObscureText = false.obs;
  final void Function(String?)? onChanged;

  CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.readOnly = false,
    this.enable = true,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.borderColor = AppColors.borderColor,
    this.borderRadius = 20.0,
    this.suffixIcon,
    this.onChanged,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    // isObscureText.value = obscureText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: TextStyle(
        //     fontSize: 6,
        //     fontWeight: FontWeight.w500,
        //     fontFamily: AppTextStyles.fontFamily,
        //   ),
        // ),
        // const SizedBox(height: 3),
        TextFormField(
          onChanged: onChanged,
          readOnly: readOnly,
          enabled: enable,
          controller: controller,
          keyboardType: keyboardType,
          // obscureText: isObscureText.value,
          validator: validator,
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar(
              anchors: editableTextState.contextMenuAnchors,
              children: [
                TextButton(
                  onPressed:
                      () => editableTextState.pasteText(
                        SelectionChangedCause.toolbar,
                      ),
                  child: const Text('Paste'),
                ),
              ],
            );
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppConstants.commonFont,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.hintColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppConstants.commonFont,
            ),
            // suffix: Visibility(
            //   visible: obscureText,
            //   child: InkWell(
            //     onTap: () {
            //       isObscureText.value = !isObscureText.value;
            //     },
            //     child: Icon(
            //       isObscureText.value
            //           ? Icons.visibility_off
            //           : Icons.visibility,
            //     ),
            //   ),
            // ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: BorderSide(color: AppColors.textFieldColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: BorderSide(
                color: enable ? borderColor : AppColors.textFieldColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0.h,
              horizontal: 15.0.w,
            ),
          ),
        ),
      ],
    );
  }
}
