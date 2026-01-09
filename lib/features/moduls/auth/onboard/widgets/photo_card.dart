import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';

class PhotoCard extends StatelessWidget {
  final String image;
  final VoidCallback? onDelete;

  const PhotoCard({super.key, required this.image, this.onDelete});

  @override
  Widget build(BuildContext context) {
    debugPrint(image);
    return image.isEmpty
        ? DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(20.r),
            dashPattern: const [4, 5],
          ),

          child: Center(
            child: Card(
              color: AppColors.progressDissableColor,
              child: const Icon(Icons.add),
            ),
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: CommonAssets.networkImage(image!),
          // Image.file(
          //   image.value!,
          //   fit: BoxFit.cover,
          //   width: 167.w,
          //   height: 110.h,
          // ),
        );
  }
}
