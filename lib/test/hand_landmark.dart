import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/moduls/posture/controller/posture_controller.dart';
import 'package:matchster/main.dart';

class HandTrackerView extends StatefulWidget {
  const HandTrackerView({super.key});

  @override
  State<HandTrackerView> createState() => _HandTrackerViewState();
}

class _HandTrackerViewState extends State<HandTrackerView> {
  CameraController? _controller;
  // The plugin instance that will handle all the heavy lifting.
  HandLandmarkerPlugin? _plugin;
  // The results from the plugin will be stored in this list.
  List<Hand> _landmarks = [];
  // A flag to show a loading indicator while the camera and plugin are initializing.
  bool _isInitialized = false;
  // A guard to prevent processing multiple frames at once.
  final postureController = Get.find<PostureController>();
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  int _stableFrames = 0;
  int requiredFrames = 5;
  Future<void> _initialize() async {
    final camera = camerasList.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => camerasList.first,
    );
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // Create an instance of our plugin with custom options.
    _plugin = HandLandmarkerPlugin.create(
      numHands: 2,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.gpu,
    );

    await _controller!.initialize();
    await _controller!.startImageStream(_processCameraImage);

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    // Stop the image stream and dispose of the controller.
    _controller?.stopImageStream();
    _controller?.dispose();
    // Dispose of the plugin to release native resources.
    _plugin?.dispose();
    super.dispose();
  }

  double _distance(Landmark a, Landmark b) {
    return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));
  }

  bool _isExtended(
    List<Landmark> l,
    int tip,
    int pip, {
    double threshold = 0.05,
  }) {
    return (l[tip].y - l[pip].y) < -threshold;
  }

  bool _isFolded(
    List<Landmark> l,
    int tip,
    int pip, {
    double threshold = 0.02,
  }) {
    return (l[tip].y - l[pip].y) > -threshold;
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (postureController.isDetecting.value ||
        !_isInitialized ||
        _plugin == null ||
        postureController.isCapturing.value)
      return;

    postureController.isDetecting.value = true;

    try {
      final hands = _plugin!.detect(
        image,
        _controller!.description.sensorOrientation,
      );

      postureController.hands.value = hands;

      if (hands.isNotEmpty) {
        final l = hands.first.landmarks;

        if (postureController.currentStep.value == GestureStep.detectVictory) {
          if (isVictory(l)) {
            _stableFrames++;

            if (_stableFrames >= requiredFrames) {
              _stableFrames = 0;
              await _captureAndStop();
            }
          } else {
            _stableFrames = 0;
          }
        } else if (postureController.currentStep.value ==
            GestureStep.detectFist) {
          if (_isFist(l)) {
            _stableFrames++;

            if (_stableFrames >= requiredFrames) {
              _stableFrames = 0;
              await _captureAndStop();
            }
          } else {
            _stableFrames = 0;
          }
        }
      }
    } catch (e) {
      debugPrint('Error detecting landmarks: $e');
    } finally {
      postureController.isDetecting.value = false;
    }
  }

  Future<void> _captureAndStop() async {
    try {
      postureController.isCapturing.value = true;

      await _controller?.stopImageStream();

      final XFile file = await _controller!.takePicture();

      postureController.lastCapturedPath.value = file.path;

      debugPrint("Saved: ${file.path}");
    } catch (e) {
      debugPrint("Capture error: $e");
    } finally {
      postureController.isCapturing.value = false;
    }
  }

  bool _isFist(List<Landmark> l) {
    bool down(int tip, int pip) => l[tip].y > l[pip].y;

    return down(8, 6) && down(12, 10) && down(16, 14) && down(20, 18);
  }

  bool isVictory(List<Landmark> l) {
    final indexUp = _isExtended(l, 8, 6);
    final middleUp = _isExtended(l, 12, 10);
    final ringDown = _isFolded(l, 16, 14);
    final pinkyDown = _isFolded(l, 20, 18);

    final spread = (l[8].x - l[12].x).abs() > 0.04;

    return indexUp && middleUp && ringDown && pinkyDown && spread;
  }

  bool isFist(List<Landmark> l) {
    final allFolded =
        _isFolded(l, 8, 6) &&
        _isFolded(l, 12, 10) &&
        _isFolded(l, 16, 14) &&
        _isFolded(l, 20, 18);

    final palm = l[0]; // wrist
    final compact =
        _distance(l[8], palm) < 0.18 &&
        _distance(l[12], palm) < 0.18 &&
        _distance(l[16], palm) < 0.18 &&
        _distance(l[20], palm) < 0.18;

    return allFolded && compact;
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while initializing.
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final controller = _controller!;
    final previewSize = controller.value.previewSize!;
    final previewAspectRatio = previewSize.height / previewSize.width;

    return Obx(
      () => Center(
        child: AspectRatio(
          aspectRatio: previewAspectRatio,
          child: Stack(
            children: [
              CameraPreview(controller),
              CustomPaint(
                // Tell the painter to fill the available space
                size: Size.infinite,
                painter: LandmarkPainter(
                  hands: postureController.hands.value,
                  // Pass the camera's resolution explicitly
                  previewSize: previewSize,
                  lensDirection: controller.description.lensDirection,
                  sensorOrientation: controller.description.sensorOrientation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A custom painter that renders the hand landmarks and connections.
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
    final scale = size.width / previewSize.height;

    // final paint =
    //     Paint()
    //       ..color = Colors.red
    //       ..strokeWidth = 8 / scale
    //       ..strokeCap = StrokeCap.round;

    final linePaint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 4 / scale;

    canvas.save();

    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(sensorOrientation * math.pi / 180);

    if (lensDirection == CameraLensDirection.front) {
      canvas.scale(-1, 1);
      canvas.rotate(math.pi);
    }

    canvas.scale(scale);

    // Assign logicalWidth to the sensor's width and logicalHeight to the sensor's height.
    final logicalWidth = previewSize.width;
    final logicalHeight = previewSize.height;

    for (final hand in hands) {
      for (final landmark in hand.landmarks) {
        // Now dx is scaled by width, and dy is scaled by height.
        final dx = (landmark.x - 0.5) * logicalWidth;
        final dy = (landmark.y - 0.5) * logicalHeight;
        // canvas.drawCircle(Offset(dx, dy), 8 / scale, paint);
      }
      for (final connection in HandLandmarkConnections.connections) {
        final start = hand.landmarks[connection[0]];
        final end = hand.landmarks[connection[1]];
        final startDx = (start.x - 0.5) * logicalWidth;
        final startDy = (start.y - 0.5) * logicalHeight;
        final endDx = (end.x - 0.5) * logicalWidth;
        final endDy = (end.y - 0.5) * logicalHeight;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Helper class.
class HandLandmarkConnections {
  static const List<List<int>> connections = [
    [0, 1], [1, 2], [2, 3], [3, 4], // Thumb
    [0, 5], [5, 6], [6, 7], [7, 8], // Index finger
    [5, 9], [9, 10], [10, 11], [11, 12], // Middle finger
    [9, 13], [13, 14], [14, 15], [15, 16], // Ring finger
    [13, 17], [0, 17], [17, 18], [18, 19], [19, 20], // Pinky
  ];
}
