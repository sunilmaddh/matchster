import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.name,
    required this.onTop,
    this.isEnable = false,
  });
  final String name;
  final VoidCallback onTop;
  bool isEnable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              isEnable ? AppColors.gradiantPrimary : AppColors.appGradiantColor,
        ),
        child: CommonText.text(
          name,
          color: isEnable ? AppColors.whiteColor : AppColors.appDisableButton,
        ),
      ),
    );
  }
}
