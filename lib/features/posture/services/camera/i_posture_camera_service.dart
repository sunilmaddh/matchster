import 'package:camera/camera.dart';

abstract class IPostureCameraService {
  CameraController? get controller;
  bool get isReady;
  Future<void> initialize(CameraDescription camera);
  Future<void> startImageStream(
    Future<void> Function(CameraImage image) onImage,
  );
  Future<void> stopImageStream();
  Future<XFile?> takePicture();
  Future<void> dispose();
}
