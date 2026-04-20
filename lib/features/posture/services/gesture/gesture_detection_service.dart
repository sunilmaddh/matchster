import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/posture/models/gesture_detection_result.dart';
import 'i_gesture_detection_service.dart';

class GestureDetectionService implements IGestureDetectionService {
  HandLandmarkerPlugin? _plugin;

  @override
  Future<void> initialize() async {
    _plugin = HandLandmarkerPlugin.create(
      numHands: 2,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.gpu,
    );
  }

  @override
  Future<GestureDetectionResult> detectGesture({
    required CameraImage image,
    required int sensorOrientation,
    required GestureStep step,
  }) async {
    try {
      final List<Hand> hands = _plugin!.detect(image, sensorOrientation);

      if (hands.isEmpty) {
        return const GestureDetectionResult(
          isGestureValid: false,
          status: 'No hand detected',
          hands: [],
        );
      }

      final List<Landmark> landmarks = hands.first.landmarks;
      bool matched = false;

      switch (step) {
        case GestureStep.detectVictory:
          matched = _isVictory(landmarks);
          break;
        case GestureStep.detectThumbOnchin:
          matched = _isThinkingPose(landmarks);
          break;
        case GestureStep.detectOk:
          matched = _isOkSign(landmarks);
          break;
        case GestureStep.completed:
          matched = false;
          break;
      }

      return GestureDetectionResult(
        isGestureValid: matched,
        status: matched ? 'Gesture detected' : 'Show correct gesture',
        hands: hands,
      );
    } catch (_) {
      return const GestureDetectionResult(
        isGestureValid: false,
        status: 'Gesture detection failed',
        hands: [],
      );
    }
  }

  bool _isVictory(List<Landmark> l) {
    final Landmark wrist = l[0];

    double dist(int tip) => math.sqrt(
      math.pow(l[tip].x - wrist.x, 2) + math.pow(l[tip].y - wrist.y, 2),
    );

    final bool indexFar = dist(8) > 0.18;
    final bool middleFar = dist(12) > 0.18;
    final bool ringClose = dist(16) < 0.24;
    final bool pinkyClose = dist(20) < 0.24;
    final bool fingersSeparated = (l[8].x - l[12].x).abs() > 0.02;

    return indexFar && middleFar && ringClose && pinkyClose && fingersSeparated;
  }

  bool _isOkSign(List<Landmark> l) {
    final Landmark thumbTip = l[4];
    final Landmark indexTip = l[8];
    final Landmark wrist = l[0];

    final bool circle = _distance(thumbTip, indexTip) < 0.06;
    final bool indexNotFolded = _distance(indexTip, wrist) > 0.16;

    bool isExtended(int tip) => _distance(l[tip], wrist) > 0.20;

    return circle &&
        indexNotFolded &&
        isExtended(12) &&
        isExtended(16) &&
        isExtended(20);
  }

  bool _isThinkingPose(List<Landmark> l) {
    final double palmSize = _distance(l[0], l[9]);

    final bool indexBent = _distance(l[8], l[6]) < palmSize * 0.40;
    final bool thumbBent = _distance(l[4], l[3]) < palmSize * 0.40;

    bool isFolded(int tip) => _distance(l[tip], l[0]) < palmSize * 1.25;

    return indexBent &&
        thumbBent &&
        isFolded(12) &&
        isFolded(16) &&
        isFolded(20);
  }

  double _distance(Landmark a, Landmark b) {
    return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));
  }

  @override
  Future<void> dispose() async {
    _plugin?.dispose();
    _plugin = null;
  }
}
