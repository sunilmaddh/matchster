import 'package:camera/camera.dart';
import 'package:matchster/features/posture/models/face_detection_result.dart';

abstract class IFaceDetectionService {
  Future<void> initialize();

  Future<FaceDetectionResult> detectFace({
    required CameraImage image,
    required int sensorOrientation,
  });

  Future<void> dispose();
}
