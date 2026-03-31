import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class NoMoreProfileWidget extends StatelessWidget {
  final Function? retrieveProfileonTap;
  const NoMoreProfileWidget({super.key, this.retrieveProfileonTap});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 0.h),
            child: Column(
              children: [
                CommonAssets.imageAsset(
                  AppAssets.noMProfile,
                  // height: 150.h,
                  // width: 150.w,
                ),
                30.hBox,
                Padding(
                  padding: 40.horizontalPadding,
                  child: CommonText.text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    AppConstants.nOProfilesTtile,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.hBox,
                CommonText.text(
                  maxLines: 3,
                  AppConstants.noProfileDes,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                50.hBox,
                AppButton(
                  isEnable: true,
                  name: "Alter radius area ",
                  onTop: () {},
                ),
                20.hBox,
                AppButton(
                  isBlack: true,
                  isEnable: true,
                  name: "Retrieve swiped profiles",
                  onTop: () {
                    retrieveProfileonTap?.call();
                  },
                ),
              ],
            ),
          ),

          // Positioned(
          //   left: 16.w,
          //   right: 16.w,
          //   bottom:
          //       kBottomNavigationBarHeight +
          //       MediaQuery.of(context).padding.bottom +
          //       40.h,
          //   child: AppButton(name: "Update Preferences", onTop: () {}),
          // ),
        ],
      ),
    );
  }
}
