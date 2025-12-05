import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/view/posture_gesture_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/face_overlay_widgets.dart';

class FaceRecognisationPage extends StatelessWidget {
  FaceRecognisationPage({super.key});
  final controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        onTap: () {
          Get.to(PostureGestureScreen());
        },
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Obx(() {
                final img = controller.faceImage.value;
                final face = controller.detectedFace.value;
                final imgSize = controller.imageSize.value;

                if (img == null) {
                  return const Center(child: Text("No image loaded"));
                }

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(img, fit: BoxFit.fitHeight),
                    ),

                    Visibility(
                      visible: controller.isFaceRecognigation.isTrue,
                      child: FaceOverlayWidget(
                        face: face,
                        imageSize: imgSize,
                        maxW: constraints.maxWidth,
                        maxH: constraints.maxHeight,
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child:
                          controller.isHumanProccessing.isTrue
                              ? SizedBox.shrink()
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  90.hBox,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonText.text(
                                      maxLines: 2,
                                      color: Colors.white,
                                      AppConstants.faceRecognisationTitle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: LoadingIndicator(
                                      strokeWidth: 1,
                                      colors: [AppColors.appDisableButton],
                                      indicatorType:
                                          Indicator.lineSpinFadeLoader,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ],
                );
              });
            },
          ),
          Obx(
            () => Visibility(
              visible: controller.isHumanProccessing.isTrue,
              child: Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xff636363).withOpacity(0.90),
                  child: Padding(
                    padding: 30.horizontalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppAssets.successfully),
                        CommonText.text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          controller.isHumanProccessingStep2.isTrue
                              ? AppConstants.successfullyVerified
                              : AppConstants.checkingForHuman,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        20.hBox,
                        CommonText.text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          controller.isHumanProccessingStep2.isTrue
                              ? AppConstants.humanRecognization2
                              : AppConstants.humanRecognization1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),

                        40.hBox,

                        controller.isHumanProccessingStep2.isFalse
                            ? SizedBox(
                              width: 60,
                              height: 60,
                              child: LoadingIndicator(
                                strokeWidth: 1,
                                colors: [AppColors.appDisableButton],
                                indicatorType: Indicator.lineSpinFadeLoader,
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          90.hBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonText.text(
              maxLines: 2,
              color: Colors.white,
              AppConstants.faceRecognisationTitle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: LoadingIndicator(
              strokeWidth: 1,
              colors: [AppColors.appDisableButton],
              indicatorType: Indicator.lineSpinFadeLoader,
            ),
          ),
        ],
      ),
    );
  }
}
