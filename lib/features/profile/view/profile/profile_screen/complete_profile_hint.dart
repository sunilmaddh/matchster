import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class CompleteProfileHint extends StatelessWidget {
  const CompleteProfileHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5.r),
            child: Image.asset(AppAssets.userBadge, height: 14.h, width: 14.w),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CommonText.text(
              AppStrings.completeProfileHint,
              maxLines: 2,
              fontSize: 11.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
