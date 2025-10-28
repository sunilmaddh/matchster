import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/shared/widgets/fields/common_text.dart';

class ProfilePhotoCard extends StatelessWidget {
  // final Rx<File?> image;
  // final VoidCallback? onDelete;
  String image = "";
  ProfilePhotoCard({super.key});
  // required this.image, this.onDelete

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 108.h,
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Color(0xff464646).withOpacity(0.44)),
          CommonText.text(
            "Add Photos",
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Caros",
            color: Color(0xff464646),
          ),
        ],
      ),
    );
    // Obx(() {
    //   if (image.isEmpty) {
    //     return DottedBorder(
    //       options: RoundedRectDottedBorderOptions(
    //         radius: Radius.circular(20.r),
    //         dashPattern: const [4, 5],
    //       ),

    //       child: Center(
    //         child: Card(
    //           color: AppColors.progressDissableColor,
    //           child: const Icon(Icons.add),
    //         ),
    //       ),
    //     );
    //   } else {
    //     return ClipRRect(
    //       borderRadius: BorderRadius.circular(20.r),
    //       child: SizedBox(),
    //       // Image.file(
    //       //   image.value!,
    //       //   fit: BoxFit.cover,
    //       //   width: 167.w,
    //       //   height: 133.h,
    //       // ),
    //     );
    //   }
    // });
  }
}
