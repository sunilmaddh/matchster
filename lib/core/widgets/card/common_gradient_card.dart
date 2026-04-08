import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class CommonGradientCard extends StatelessWidget {
  const CommonGradientCard({
    super.key,
    this.isGradient = true,
    required this.widget,
  });
  final bool isGradient;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isGradient == false ? AppColors.commonLightColor : null,
        gradient: isGradient == true ? AppColors.gradientBoxCircle : null,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: widget,
    );
  }
}
