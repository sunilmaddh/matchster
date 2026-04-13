import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_font_type.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class DeviderWidget extends StatelessWidget {
  const DeviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.horizontalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: SizedBox(
              height: 3.h,
              child: Divider(color: AppColors.blackColor),
            ),
          ),
          20.wBox,
          CommonText.labelLarge(
            AppConstants.oRcontinue,

            fontWeight: FontWeight.w400,
            fontType: AppFontType.mono,
            color: AppColors.blackColor,
          ),
          20.wBox,
          Expanded(
            child: SizedBox(
              height: 1.h,
              child: Divider(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
