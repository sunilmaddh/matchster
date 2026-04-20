import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class CircleGradiantCard extends StatelessWidget {
  const CircleGradiantCard({
    super.key,
    this.isGradiant = true,
    required this.widget,
    this.height = 50,
    this.width = 50,
  });
  final bool isGradiant;
  final Widget widget;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
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
