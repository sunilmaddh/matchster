import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class TextWithWidget extends StatelessWidget {
  const TextWithWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.widget,
  });
  final String title;
  final String subTitle;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.text(
          title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.blackColor,
        ),

        CommonText.text(
          subTitle,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        10.hBox,
        widget,
      ],
    );
  }
}
