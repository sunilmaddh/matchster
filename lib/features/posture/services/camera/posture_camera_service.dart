import 'package:camera/camera.dart';
import 'package:matchster/features/posture/services/camera/i_posture_camera_service.dart';

class PostureCameraService implements IPostureCameraService {
  @override
  CameraController? controller;

  @override
  bool get isReady =>
      controller != null &&
      controller!.value.isInitialized &&
      controller!.value.previewSize != null;

  @override
  Future<void> initialize(CameraDescription camera) async {
    controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await controller!.initialize();
  }

  @override
  Future<void> startImageStream(
    Future<void> Function(CameraImage image) onImage,
  ) async {
    if (controller == null || controller!.value.isStreamingImages) return;
    await controller!.startImageStream(onImage);
  }

  @override
  Future<void> stopImageStream() async {
    if (controller == null || !controller!.value.isStreamingImages) return;
    await controller!.stopImageStream();
  }

  @override
  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return null;
    return controller!.takePicture();
  }

  @override
  Future<void> dispose() async {
    if (controller != null) {
      if (controller!.value.isStreamingImages) {
        await controller!.stopImageStream();
      }
      await controller!.dispose();
      controller = null;
    }
  }
}
