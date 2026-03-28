import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class NoMoreProfileWidget extends StatelessWidget {
  const NoMoreProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 0.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  30.hBox,
                  CommonAssets.imageAsset(AppAssets.noMProfile),
                  30.hBox,
                  Padding(
                    padding: 40.horizontalPadding,
                    child: CommonText.displaySmall(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      AppConstants.nOProfilesTtile,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  20.hBox,
                  CommonText.titleMedium(
                    maxLines: 3,
                    AppConstants.noProfileDes,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center,
                  ),
                  50.hBox,
                  AppButton(
                    isEnable: true,
                    name: AppStrings.updatePreference,
                    onTop: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
