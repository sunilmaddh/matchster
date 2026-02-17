import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_text_style.dart';
import 'package:matchster/core/utils/extentions.dart';

// ignore: must_be_immutable
class CustomFormField2 extends StatelessWidget {
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
  RxBool isObscureText = false.obs;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;

  CustomFormField2({
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
    this.borderColor = AppColors.appDisableButton,
    this.borderRadius = 20.0,
    this.suffixIcon,
    this.onChanged,
    this.onSuffixTap,
    this.inputFormatters = const [],
    this.maxLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    isObscureText.value = obscureText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: TextStyle(
        //     fontSize: 16.sp,
        //     fontWeight: FontWeight.w500,
        //     fontFamily: AppTextStyles.fontFamily,
        //   ),
        // ),
        // const SizedBox(height: 3),
        Obx(
          () => TextFormField(
            maxLength: maxLength,
            onChanged: onChanged,
            readOnly: readOnly,
            enabled: enable,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isObscureText.value,
            validator: validator,
            inputFormatters: inputFormatters,
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
              counterText: '',
              labelStyle: TextStyle(color: AppColors.appDisableButton),
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.appDisableButton,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Suisse Intl",
              ),
              suffix: Visibility(
                visible: obscureText,
                child: InkWell(
                  onTap: () {
                    isObscureText.value = !isObscureText.value;
                  },
                  child: Icon(
                    isObscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.blackColor.withAlpha(64),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.blackColor.withAlpha(64),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.textFieldColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.blackColor.withAlpha(64),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 15.0.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
