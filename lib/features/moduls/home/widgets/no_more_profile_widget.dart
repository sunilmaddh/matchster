import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class NoMoreProfileWidget extends StatelessWidget {
  const NoMoreProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 120.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonAssets.svgAsset(
                    AppAssets.noMoreProfile,
                    height: 150.h,
                    width: 150.w,
                  ),
                  60.hBox,
                  CommonText.text(
                    AppConstants.nOProfilesTtile,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  15.hBox,
                  CommonText.text(
                    maxLines: 3,
                    AppConstants.noProfileDes,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 16.w,
            right: 16.w,
            bottom:
                kBottomNavigationBarHeight +
                MediaQuery.of(context).padding.bottom +
                40.h,
            child: AppButton(name: "Update Preferences", onTop: () {}),
          ),
        ],
      ),
    );
  }
}
