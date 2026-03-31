import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class CommonWrapCard extends StatelessWidget {
  const CommonWrapCard({super.key, required this.text, required this.img});
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 8.horizontalPadding + 4.verticalPadding,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(width: 1.w, color: Color(0xff464646).withAlpha(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: 5.allPadding,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF4F4F4),
            ),
            child: CommonText.text(img),
          ),
          5.wBox,
          CommonText.text(AppMethods.capitalizeFirst(text)),
        ],
      ),
    );
  }
}
