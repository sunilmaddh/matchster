import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/bottomsheet/image_picker_bottom_sheet.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class PhotoReviewBottomsheet {
  static void show({required Function(File file) onImageSelected}) {
    CustomBottomSheet.show(
      padding: EdgeInsets.zero,
      borderRadius: 40.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.hBox,
          CommonAssets.svgAsset(AppAssets.previewErrorAssets),
          50.hBox,
          Padding(
            padding: 15.horizontalPadding,
            child: CommonText.text(
              AppConstants.photoReviewText,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          Padding(
            padding: 15.horizontalPadding,
            child: CommonText.text(
              textAlign: TextAlign.center,
              maxLines: 4,
              AppConstants.photoReviewDis,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          30.hBox,
          Container(
            width: Get.width,
            height: 0.5.h,
            color: AppColors.blackColor.withAlpha(128),
          ),

          10.hBox,
          InkWell(
            onTap: () {
              Get.back();
              ImagePickerBottomSheet.show(
                onImageSelected: (v) {
                  onImageSelected(v);
                },
              );
            },
            child: CommonText.text(
              textAlign: TextAlign.center,
              maxLines: 4,
              AppConstants.uploadAnOtherPhoto,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          10.hBox,
        ],
      ),
    );
  }
}

class Divider {}
