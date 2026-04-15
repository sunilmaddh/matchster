import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';

class ToggleWithText extends StatelessWidget {
  const ToggleWithText({
    super.key,
    required this.controller,
    required this.onTop1,
    required this.onTop2,
  });

  final FilterController controller;
  final VoidCallback onTop1;
  final VoidCallback onTop2;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: const Color(0xffD5D5D5),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 2.22.r,
              spreadRadius: 0.83.r,
              offset: const Offset(0, 1.67),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToggleItem(
              text: 'km',
              isSelected: controller.isKm.value,
              onTap: onTop1,
            ),
            4.wBox,
            _ToggleItem(
              text: 'mi',
              isSelected: !controller.isKm.value,
              onTap: onTop2,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  const _ToggleItem({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        alignment: Alignment.center,
        decoration:
            isSelected
                ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackColor,
                )
                : null,
        child: CommonText.text(
          text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color:
              isSelected
                  ? AppColors.whiteColor
                  : AppColors.distenceSwitchTextColor,
        ),
      ),
    );
  }
}
