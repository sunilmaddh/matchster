import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

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
        CommonText.titleMedium(
          title,

          fontWeight: FontWeight.w700,
          color: AppColors.blackColor,
        ),

        CommonText.labelLarge(
          subTitle,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        10.hBox,
        widget,
      ],
    );
  }
}
