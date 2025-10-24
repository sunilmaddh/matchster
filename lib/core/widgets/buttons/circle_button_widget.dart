import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class CircleButtonWidget extends StatelessWidget {
  final bool isEnable;
  final VoidCallback? onTap;
  final double size;
  final IconData icon;

  const CircleButtonWidget({
    super.key,
    this.isEnable = true,
    this.onTap,
    this.size = 64,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        height: size.h,
        width: size.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              isEnable
                  ? AppColors.gradiantPrimary
                  : AppColors.circleGradiantColor,
        ),
        child: Icon(icon, color: AppColors.whiteColor),
      ),
    );
  }
}
