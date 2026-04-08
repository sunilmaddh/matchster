import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class CircleGradiantCard extends StatelessWidget {
  const CircleGradiantCard({
    super.key,
    this.isGradiant = true,
    required this.widget,
  });
  final bool isGradiant;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient:
            isGradiant
                ? AppColors.gradientCircle
                : LinearGradient(
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: widget,
    );
  }
}
