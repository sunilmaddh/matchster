import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class ProfilePhotoCard extends StatelessWidget {
  // final File? image;
  // final VoidCallback? onDelete;
  // String image = "";
  ProfilePhotoCard({super.key});
  // required this.image, this.onDelete

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 110.w,
      height: 108.h,
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
    //   if (image != null) {
    //     return Container(
    //       // width: 110.w,
    //       height: 108.h,
    //       decoration: BoxDecoration(
    //         color: Color(0xffF1F1F1),
    //         borderRadius: BorderRadius.circular(20),
    //       ),

    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Icon(Icons.add, color: Color(0xff464646).withOpacity(0.44)),
    //           CommonText.text(
    //             "Add Photos",
    //             fontSize: 10.sp,
    //             fontWeight: FontWeight.w500,
    //             fontFamily: "Caros",
    //             color: Color(0xff464646),
    //           ),
    //         ],
    //       ),
    //     );
    //   } else {
    //     return ClipRRect(
    //       borderRadius: BorderRadius.circular(20.r),
    //       child: Image.file(
    //         image!,
    //         fit: BoxFit.cover,
    //         width: 167.w,
    //         height: 133.h,
    //       ),
    //     );
    //   }
    // });
  }
}
