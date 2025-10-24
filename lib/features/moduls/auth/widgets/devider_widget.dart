import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class DeviderWidget extends StatelessWidget {
  const DeviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: SizedBox(
              height: 3.h,
              child: Divider(color: AppColors.deviderColor),
            ),
          ),
          20.wBox,
          CommonText.text(
            AppConstants.oRcontinue,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "DM Sans",
            color: AppColors.deviderColor,
          ),
          20.wBox,
          Expanded(
            child: SizedBox(
              height: 3.h,
              child: Divider(color: AppColors.deviderColor),
            ),
          ),
        ],
      ),
    );
  }
}
