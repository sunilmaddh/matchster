import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class FilterSwipButton extends StatelessWidget {
  const FilterSwipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 7.horizontalPadding + 7.verticalPadding,
      decoration: BoxDecoration(
        gradient: AppColors.gradiantPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SwipeButton(
        borderRadius: BorderRadius.circular(14),
        inactiveThumbColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        activeTrackColor: Colors.transparent,
        thumb: Container(
          height: 37.h,
          // width: 37.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.whiteColor,
          ),
          child: Icon(Icons.check, color: AppColors.primary),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: CommonText.labelLarge(
                AppStrings.filterString.unlockMembership,
                color: AppColors.whiteColor,
              ),
            ),

            Positioned(
              right: 26.w,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ),
            Positioned(
              right: 18.w,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.progressDissableColor,
                size: 16,
              ),
            ),
            Positioned(
              right: 10.w,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.whiteColor,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
