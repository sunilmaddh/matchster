import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class PhotoCard extends StatelessWidget {
  final Rx<File?> image;
  final VoidCallback? onDelete;

  const PhotoCard({super.key, required this.image, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (image.value == null) {
        return DottedBorder(
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
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.file(
            image.value!,
            fit: BoxFit.cover,
            width: 167.w,
            height: 133.h,
          ),
        );
      }
    });
  }
}
