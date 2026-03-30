import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class FilterHeaderCard extends StatelessWidget {
  const FilterHeaderCard({
    super.key,
    required this.onTop,
    required this.text,
    required this.gradient,
  });

  final VoidCallback onTop;
  final String text;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        height: 39.h,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            if (gradient != null)
              BoxShadow(
                color: AppColors.blackColor.withAlpha(26), // 10%
                blurRadius: 4.r,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: CommonText.titleMedium(
          text,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
