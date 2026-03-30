import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/main.dart';

enum GestureStep { detectVictory, detectOk, detectThumbOnchin, completed }

class PostureController extends BaseController {
  final currentStep = GestureStep.detectVictory.obs;
  RxInt postureIndex = 0.obs;
  final List<String> postureList = [
    AppAssets.posture1,
    AppAssets.posture2,
    AppAssets.posture3,
  ];
  final handsLand = <Hand>[].obs;

  final isDetecting = false.obs;
  final isCapturing = false.obs;
  CameraController? controller;
  RxBool isInitialized = false.obs;

  final lastCapturedPath = RxnString();

  void moveToNextStep() {
    if (currentStep.value == GestureStep.detectVictory) {
      currentStep.value = GestureStep.detectThumbOnchin;
      postureIndex.value = 1;
    } else if (currentStep.value == GestureStep.detectThumbOnchin) {
      currentStep.value = GestureStep.detectOk;
      postureIndex.value = 2;
    } else {
      currentStep.value = GestureStep.completed;
    }
  }

  HandLandmarkerPlugin? plugin;
  int _stableFrames = 0;
  int requiredFrames = 5;
  Future<void> initialize() async {
    final camera = camerasList.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => camerasList.first,
    );
    controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // Create an instance of our plugin with custom options.
    plugin = HandLandmarkerPlugin.create(
      numHands: 2,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.gpu,
    );

    await controller!.initialize();
    await controller!.startImageStream(processCameraImage);

    if (!isInitialized.value) {
      isInitialized.value = true;
    } else {
      isInitialized.value = false;
    }
  }

  void resetImage() {
    lastCapturedPath.value = null;
  }

  Future<void> restartDetection() async {
    if (controller == null) return;
    _stableFrames = 0;
    isCapturing.value = false;
    isDetecting.value = false;
    lastCapturedPath.value = null;
    await controller!.startImageStream(processCameraImage);
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (isDetecting.value ||
        !isInitialized.value ||
        plugin == null ||
        isCapturing.value)
      return;

    isDetecting.value = true;

    try {
      final hands = plugin!.detect(
        image,
        controller!.description.sensorOrientation,
      );

      handsLand.value = hands;

      if (hands.isNotEmpty) {
        final l = hands.first.landmarks;

        if (currentStep.value == GestureStep.detectVictory) {
          debugPrint("Is victory-1-${l.length}");
          if (isVictory(l)) {
            debugPrint("Is victory-2");
            _stableFrames++;

            if (_stableFrames >= requiredFrames) {
              debugPrint("Is victory-3");
              _stableFrames = 0;
              await Future.delayed(Duration(seconds: 2));
              await _captureAndStop();
            }
          } else {
            _stableFrames = 0;
          }
        } else if (currentStep.value == GestureStep.detectThumbOnchin) {
          debugPrint("Is victory-1-ok-${l.length}");
          if (isThinkingPose(l)) {
            debugPrint("Is victory-2-ok-thumb-${l.length}");
            _stableFrames++;
            debugPrint("Is victory-3-ok-thumb-$_stableFrames");
            if (_stableFrames <= requiredFrames) {
              debugPrint("Is victory-3-ok-thumb-${l.length}");
              _stableFrames = 0;
              await Future.delayed(Duration(seconds: 2));
              await _captureAndStop();
            }
          } else {
            _stableFrames = 0;
          }
        } else if (currentStep.value == GestureStep.detectOk) {
          debugPrint("Is victory-1-ok-${l.length}");
          if (isOkSign(l)) {
            debugPrint("Is victory-2-ok-${l.length}");
            _stableFrames++;
            debugPrint("Is victory-3-ok-$_stableFrames");
            if (_stableFrames <= requiredFrames) {
              debugPrint("Is victory-3-ok-${l.length}");
              _stableFrames = 0;
              await Future.delayed(Duration(seconds: 2));
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
      isDetecting.value = false;
    }
  }

  Future<void> _captureAndStop() async {
    try {
      isCapturing.value = true;
      await controller?.stopImageStream();
      final XFile file = await controller!.takePicture();
      lastCapturedPath.value = file.path;
      debugPrint("Saved: ${file.path}");
    } catch (e) {
      debugPrint("Capture error: $e");
    } finally {
      isCapturing.value = false;
    }
  }

  bool isVictory(List<Landmark> l) {
    final wrist = l[0];
    double dist(int tip) => math.sqrt(
      math.pow(l[tip].x - wrist.x, 2) + math.pow(l[tip].y - wrist.y, 2),
    );
    final indexFar = dist(8) > 0.23;
    final middleFar = dist(12) > 0.23;
    final ringClose = dist(16) < 0.20;
    final pinkyClose = dist(20) < 0.20;
    final fingersSeparated = (l[8].x - l[12].x).abs() > 0.03;
    return indexFar && middleFar && ringClose && pinkyClose && fingersSeparated;
  }

  bool isOkSign(List<Landmark> l) {
    final thumbTip = l[4];
    final indexTip = l[8];
    final wrist = l[0];
    final circle = _distance(thumbTip, indexTip) < 0.05;
    final indexNotFolded = _distance(indexTip, wrist) > 0.18;
    bool isExtended(int tip) => _distance(l[tip], wrist) > 0.23;
    final middleUp = isExtended(12);
    final ringUp = isExtended(16);
    final pinkyUp = isExtended(20);
    return circle && indexNotFolded && middleUp && ringUp && pinkyUp;
  }

  // bool isThinkingPose(List<Landmark> l) {
  //   double distance(Landmark a, Landmark b) =>
  //       math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));
  //   final indexBent = distance(l[8], l[6]) < 0.06;
  //   final thumbBent = distance(l[4], l[3]) < 0.06;
  //   bool isClosed(int tip, int pip) => l[tip].y > l[pip].y;
  //   final middleClosed = isClosed(12, 10);
  //   final ringClosed = isClosed(16, 14);
  //   final pinkyClosed = isClosed(20, 18);
  //   return indexBent && thumbBent && middleClosed && ringClosed && pinkyClosed;
  // }
  bool isThinkingPose(List<Landmark> l) {
    double distance(Landmark a, Landmark b) =>
        math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));

    // 🔹 Palm size reference (scale normalization)
    final palmSize = distance(l[0], l[9]);

    // 🔹 Index bent (tip close to pip relative to palm)
    final indexBent = distance(l[8], l[6]) < palmSize * 0.35;

    // 🔹 Thumb bent
    final thumbBent = distance(l[4], l[3]) < palmSize * 0.35;

    // 🔹 Other fingers folded (tip closer to palm center)
    bool isFolded(int tip) => distance(l[tip], l[0]) < palmSize * 1.2;

    final middleClosed = isFolded(12);
    final ringClosed = isFolded(16);
    final pinkyClosed = isFolded(20);

    return indexBent && thumbBent && middleClosed && ringClosed && pinkyClosed;
  }

  double _distance(Landmark a, Landmark b) {
    return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));
  }
}
