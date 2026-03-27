// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:get/get.dart';
// import 'package:matchster/core/constants/app_assets.dart';
// import 'package:matchster/core/constants/app_colors.dart';
// import 'package:matchster/core/constants/app_constants.dart';
// import 'package:matchster/core/utils/extentions.dart';
// import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
// import 'package:matchster/core/widgets/fields/common_text.dart';
// import 'package:matchster/features/modules/auth/auth_controllers/onboard_controller.dart';
// import 'package:matchster/features/modules/posture/face_recognisation_page.dart';

// class FaceRecogonizationWidget extends StatelessWidget {
//   FaceRecogonizationWidget({super.key});
//   final _controller = Get.find<OnboardController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         isCenterTitle: false,
//         title: "Face Recognisation",
//         onTop: () {},
//       ),
//       body: Obx(
//         () =>
//             _controller.isProcessing.isTrue
//                 ? SizedBox(
//                   width: 60,
//                   height: 60,
//                   child: LoadingIndicator(
//                     strokeWidth: 1,
//                     colors: [AppColors.appDisableButton],
//                     indicatorType: Indicator.lineSpinFadeLoader,
//                   ),
//                 )
//                 : _controller.faceImage.value != null
//                 ? FaceRecognisationPage()
//                 : FaceTakePictureWidget(),
//       ),
//     );
//   }
// }

// class FaceTakePictureWidget extends StatelessWidget {
//   FaceTakePictureWidget({super.key});
//   final _controller = Get.find<OnboardController>();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: 15.horizontalPadding,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CommonText.text(
//             maxLines: 4,
//             AppConstants.faceRecogonization,
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w400,
//             color: Color(0xff7B7B7B),
//           ),
//           30.hBox,
//           Image.asset(height: 270.5.h, AppAssets.photoFrame1),
//           60.hBox,
//           CommonText.text(
//             maxLines: 2,
//             AppConstants.takePictureDes,
//             textAlign: TextAlign.center,
//           ),
//           30.hBox,
//           InkWell(
//             onTap: () async {
//               _controller.pickImageFromCamera();
//               if (_controller.faceImage.value != null) {
//                 await _controller.loadImageSize(_controller.faceImage.value!);
//                 await _controller.analyzeFace(_controller.faceImage.value!);
//                 // Get.to(FaceRecognisationPage());
//               }
//             },
//             child: Container(
//               alignment: Alignment.center,
//               height: 68.h,
//               width: 68.w,
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 border: Border.all(color: Color(0xffC6C6C6), width: 4.w),
//                 shape: BoxShape.circle,
//               ),
//               child: Container(
//                 margin: EdgeInsets.all(2.r),
//                 alignment: Alignment.center,
//                 height: 68.h,
//                 width: 68.w,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   border: Border.all(color: Color(0xffDEDEDE), width: 1.w),
//                   shape: BoxShape.circle,
//                 ),
//                 child: SvgPicture.asset(AppAssets.camera2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
