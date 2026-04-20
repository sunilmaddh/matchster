import 'package:camera/camera.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/posture/models/gesture_detection_result.dart';

abstract class IGestureDetectionService {
  Future<void> initialize();

  Future<GestureDetectionResult> detectGesture({
    required CameraImage image,
    required int sensorOrientation,
    required GestureStep step,
  });

  Future<void> dispose();
}
