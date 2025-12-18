import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.widget,
    this.radius = 20.0,
    this.color = AppColors.whiteColor,
    this.height = 200,
  });

  final Widget widget;
  final double radius;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.horizontalPadding + 15.verticalPadding,
      // height: height.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(
          width: 1.w,
          color: const Color(0xff363636).withAlpha(33),
        ),
      ),
      child: widget,
    );
  }
}
