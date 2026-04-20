import 'package:camera/camera.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/posture/models/face_detection_result.dart';
import 'package:matchster/features/posture/models/gesture_detection_result.dart';
import 'package:matchster/features/posture/services/camera/i_posture_camera_service.dart';

abstract class IPostureRepository {
  IPostureCameraService get cameraService;

  Future<void> initialize(CameraDescription camera);

  Future<void> startImageStream(
    Future<void> Function(CameraImage image) onImage,
  );

  Future<void> stopImageStream();

  Future<XFile?> takePicture();

  Future<FaceDetectionResult> detectFace({
    required CameraImage image,
    required int sensorOrientation,
  });

  Future<GestureDetectionResult> detectGesture({
    required CameraImage image,
    required int sensorOrientation,
    required GestureStep step,
  });

  Future<void> dispose();
}
