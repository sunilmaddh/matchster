import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/posture/controller/posture_controller.dart';
import 'package:matchster/routes/app_navigation.dart';

// ignore: must_be_immutable
class HandTrackerScreen extends BaseView<PostureController> {
  HandTrackerScreen({super.key});

  @override
  void onInit(PostureController controller) {
    controller.initialize();
    super.onInit(controller);
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: true,
        title: AppStrings.verifyPosture,
        onTop: AppNavigation.back,
      ),
      body: Obx(() {
        final CameraController? cameraController = controller.cameraController;

        if (controller.showCameraLoader.value ||
            cameraController == null ||
            !cameraController.value.isInitialized ||
            cameraController.value.previewSize == null) {
          return const _LoadingView();
        }

        final Size previewSize = cameraController.value.previewSize!;
        final double previewAspectRatio =
            previewSize.height / previewSize.width;

        return _TrackerBody(
          controller: controller,
          cameraController: cameraController,
          previewSize: previewSize,
          previewAspectRatio: previewAspectRatio,
        );
      }),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

class _TrackerBody extends StatelessWidget {
  const _TrackerBody({
    required this.controller,
    required this.cameraController,
    required this.previewSize,
    required this.previewAspectRatio,
  });

  final PostureController controller;
  final CameraController cameraController;
  final Size previewSize;
  final double previewAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: previewAspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(cameraController),
                Obx(() {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: LandmarkPainter(
                      hands: controller.handsLand.toList(),
                      previewSize: previewSize,
                      lensDirection: cameraController.description.lensDirection,
                      sensorOrientation:
                          cameraController.description.sensorOrientation,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 24,
          child: Obx(() {
            return _StatusCard(
              faceValid: controller.isFaceValid.value,
              gestureValid: controller.isGestureValid.value,
              faceText: controller.faceStatus.value,
              gestureText: controller.gestureStatus.value,
              combinedText: controller.combinedStatus.value,
              currentStep: controller.currentStep.value,
            );
          }),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.faceValid,
    required this.gestureValid,
    required this.faceText,
    required this.gestureText,
    required this.combinedText,
    required this.currentStep,
  });

  final bool faceValid;
  final bool gestureValid;
  final String faceText;
  final String gestureText;
  final String combinedText;
  final GestureStep currentStep;

  String get stepTitle {
    switch (currentStep) {
      case GestureStep.detectVictory:
        return 'Show Victory Sign';
      case GestureStep.detectThumbOnchin:
        return 'Show Thumb on Chin';
      case GestureStep.detectOk:
        return 'Show OK Sign';
      case GestureStep.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepTitle(title: stepTitle),
          const SizedBox(height: 12),
          _StatusRow(title: 'Face', isValid: faceValid, message: faceText),
          const SizedBox(height: 8),
          _StatusRow(
            title: 'Gesture',
            isValid: gestureValid,
            message: gestureText,
          ),
          const SizedBox(height: 10),
          _CombinedStatusText(text: combinedText),
        ],
      ),
    );
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _CombinedStatusText extends StatelessWidget {
  const _CombinedStatusText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 13),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.title,
    required this.isValid,
    required this.message,
  });

  final String title;
  final bool isValid;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$title: $message',
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class LandmarkPainter extends CustomPainter {
  LandmarkPainter({
    required this.hands,
    required this.previewSize,
    required this.lensDirection,
    required this.sensorOrientation,
  });

  final List<Hand> hands;
  final Size previewSize;
  final CameraLensDirection lensDirection;
  final int sensorOrientation;

  @override
  void paint(Canvas canvas, Size size) {
    final double scale = size.width / previewSize.height;

    final Paint linePaint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 4 / scale;

    canvas.save();

    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(sensorOrientation * math.pi / 180);

    if (lensDirection == CameraLensDirection.front) {
      canvas.scale(-1, 1);
      canvas.rotate(math.pi);
    }

    canvas.scale(scale);

    final double logicalWidth = previewSize.width;
    final double logicalHeight = previewSize.height;

    for (final Hand hand in hands) {
      for (final List<int> connection in HandLandmarkConnections.connections) {
        final Landmark start = hand.landmarks[connection[0]];
        final Landmark end = hand.landmarks[connection[1]];

        final double startDx = (start.x - 0.5) * logicalWidth;
        final double startDy = (start.y - 0.5) * logicalHeight;
        final double endDx = (end.x - 0.5) * logicalWidth;
        final double endDy = (end.y - 0.5) * logicalHeight;

        canvas.drawLine(
          Offset(startDx, startDy),
          Offset(endDx, endDy),
          linePaint,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant LandmarkPainter oldDelegate) {
    return oldDelegate.hands != hands ||
        oldDelegate.previewSize != previewSize ||
        oldDelegate.lensDirection != lensDirection ||
        oldDelegate.sensorOrientation != sensorOrientation;
  }
}

class HandLandmarkConnections {
  static const List<List<int>> connections = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [0, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [5, 9],
    [9, 10],
    [10, 11],
    [11, 12],
    [9, 13],
    [13, 14],
    [14, 15],
    [15, 16],
    [13, 17],
    [0, 17],
    [17, 18],
    [18, 19],
    [19, 20],
  ];
}
