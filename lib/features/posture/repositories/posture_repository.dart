import 'package:camera/camera.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/posture/models/face_detection_result.dart';
import 'package:matchster/features/posture/models/gesture_detection_result.dart';
import 'package:matchster/features/posture/services/camera/i_posture_camera_service.dart';
import 'package:matchster/features/posture/repositories/i_posture_repository.dart';
import 'package:matchster/features/posture/services/face/i_posture_face_detection_service.dart';
import 'package:matchster/features/posture/services/gesture/i_gesture_detection_service.dart';

class PostureRepository implements IPostureRepository {
  PostureRepository({
    required this.cameraService,
    required this.faceDetectionService,
    required this.gestureDetectionService,
  });

  @override
  final IPostureCameraService cameraService;
  final IFaceDetectionService faceDetectionService;
  final IGestureDetectionService gestureDetectionService;

  @override
  Future<void> initialize(CameraDescription camera) async {
    await cameraService.initialize(camera);
    await faceDetectionService.initialize();
    await gestureDetectionService.initialize();
  }

  @override
  Future<void> startImageStream(
    Future<void> Function(CameraImage image) onImage,
  ) async {
    await cameraService.startImageStream(onImage);
  }

  @override
  Future<void> stopImageStream() async {
    await cameraService.stopImageStream();
  }

  @override
  Future<XFile?> takePicture() async {
    return cameraService.takePicture();
  }

  @override
  Future<FaceDetectionResult> detectFace({
    required CameraImage image,
    required int sensorOrientation,
  }) async {
    return faceDetectionService.detectFace(
      image: image,
      sensorOrientation: sensorOrientation,
    );
  }

  @override
  Future<GestureDetectionResult> detectGesture({
    required CameraImage image,
    required int sensorOrientation,
    required GestureStep step,
  }) async {
    return gestureDetectionService.detectGesture(
      image: image,
      sensorOrientation: sensorOrientation,
      step: step,
    );
  }

  @override
  Future<void> dispose() async {
    await cameraService.dispose();
    await faceDetectionService.dispose();
    await gestureDetectionService.dispose();
  }
}
