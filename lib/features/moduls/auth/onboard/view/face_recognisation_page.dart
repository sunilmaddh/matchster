import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/widgets/face_overlay_widgets.dart';

class FaceRecognisationPage extends StatelessWidget {
  FaceRecognisationPage({super.key});
  final controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
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
                Positioned.fill(child: Image.file(img, fit: BoxFit.contain)),

                FaceOverlayWidget(
                  face: face,
                  imageSize: imgSize,
                  maxW: constraints.maxWidth,
                  maxH: constraints.maxHeight,
                ),

                _buildBottomSection(),
              ],
            );
          });
        },
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
