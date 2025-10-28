import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/view/face_recognisation_page.dart';

class FaceRecogonizationWidget extends StatelessWidget {
  FaceRecogonizationWidget({super.key});
  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return FaceTakePictureWidget();
  }
}

class FaceTakePictureWidget extends StatelessWidget {
  FaceTakePictureWidget({super.key});
  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText.text(
            maxLines: 4,
            AppConstants.faceRecogonization,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xff7B7B7B),
          ),
          30.hBox,
          Image.asset(height: 270.5.h, AppAssets.photoFrame1),
          60.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.takePictureDes,
            textAlign: TextAlign.center,
          ),
          30.hBox,
          InkWell(
            onTap: () async {
              _controller.faceImage.value =
                  await ImageUploadServices().getImageFromCamera();
              if (_controller.faceImage.value != null) {
                await _controller.loadImageSize(_controller.faceImage.value!);
                await _controller.analyzeFace(_controller.faceImage.value!);
                Get.to(FaceRecognisationPage());
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 68.h,
              width: 68.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: Color(0xffC6C6C6), width: 4.w),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(2.r),
                alignment: Alignment.center,
                height: 68.h,
                width: 68.w,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: Color(0xffDEDEDE), width: 1.w),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppAssets.camera2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class FaceRecognisationPage extends StatelessWidget {
//   FaceRecognisationPage({super.key});
//   final _controller = Get.find<OnboardController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Obx(() {
//             final img = _controller.faceImage.value;
//             final face = _controller.detectedFace.value;
//             final overlay = _buildOverlayForFace(
//               face: face,
//               imageSize: _controller.imageSize.value,
//               maxW: constraints.maxWidth,
//               maxH: constraints.maxHeight,
//             );
//             return Stack(
//               children: [
//                 if (img != null)
//                   Positioned.fill(child: Image.file(img, fit: BoxFit.contain)),
//                 if (overlay != null) overlay,

//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       90.hBox,
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CommonText.text(
//                           maxLines: 2,
//                           color: Colors.white,
//                           AppConstants.faceRecognisationTitle,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),

//                       SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: LoadingIndicator(
//                           strokeWidth: 1,
//                           colors: [AppColors.appDisableButton],
//                           indicatorType: Indicator.lineSpinFadeLoader,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           });
//         },
//       ),
//     );
//   }
// }

// Widget? _buildOverlayForFace({
//   required Face? face,
//   required Size? imageSize,
//   required double maxW,
//   required double maxH,
// }) {
//   if (face == null) return null;
//   final rect = face.boundingBox;
//   if (imageSize == null) {
//     // Fallback to previous approximation
//     final left = rect.left.clamp(0.0, maxW).toDouble();
//     final top = rect.top.clamp(0.0, maxH).toDouble();
//     final width = rect.width.clamp(20.0, maxW - left).toDouble();
//     final height = rect.height.clamp(20.0, maxH - top).toDouble();
//     return Positioned(
//       left: left,
//       top: top,
//       width: width,
//       height: height,
//       child: SvgPicture.asset(
//         AppAssets.faceDetector,
//         color: AppColors.whiteColor,
//       ),
//       // IgnorePointer(
//       //   child: Container(
//       //     decoration: BoxDecoration(
//       //       border: Border.all(color: Colors.black, width: 2),
//       //       borderRadius: BorderRadius.circular(8),
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   // Exact BoxFit.contain mapping
//   final imgW = imageSize.width;
//   final imgH = imageSize.height;
//   final scale = (maxW / imgW).clamp(0.0, double.infinity);
//   final scaledH = imgH * scale;
//   double dx = 0, dy = (maxH - scaledH) / 2;
//   if (scaledH > maxH) {
//     final scaleH = maxH / imgH;
//     final scaledW = imgW * scaleH;
//     dx = (maxW - scaledW) / 2;
//     dy = 0;
//   } else {
//     // width filled, height letterboxed
//   }

//   final left =
//       dx + rect.left * (scaledH > maxH ? (maxH / imgH) : (maxW / imgW));
//   final top = dy + rect.top * (scaledH > maxH ? (maxH / imgH) : (maxW / imgW));
//   final width = rect.width * (scaledH > maxH ? (maxH / imgH) : (maxW / imgW));
//   final height = rect.height * (scaledH > maxH ? (maxH / imgH) : (maxW / imgW));
//   return Positioned(
//     left: left,
//     top: top,
//     width: width,
//     height: height,
//     child: IgnorePointer(
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.white, width: 2),
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     ),
//   );
// }
