import 'dart:async';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/features/posture/helper/input_image_converter.dart';
import 'package:matchster/features/posture/services/matchster_face_detection_service.dart';

class FaceCameraController extends GetxController {
  FaceCameraController({
    required this.cameras,
    required this.faceDetectionService,
  });

  final List<CameraDescription> cameras;
  final MatchsterFaceDetectionService faceDetectionService;

  CameraController? cameraController;
  CameraDescription? selectedCamera;

  final RxBool isCameraInitialized = false.obs;
  final RxBool isStreaming = false.obs;
  final RxBool isProcessingFrame = false.obs;
  final RxBool isCaptureEnabled = false.obs;

  final RxBool isFaceDetected = false.obs;
  final RxBool isSingleFace = false.obs;
  final RxBool isFaceCentered = false.obs;
  final RxBool isLeftEyeOpen = false.obs;
  final RxBool isRightEyeOpen = false.obs;

  final RxString statusMessage = 'Initializing camera...'.obs;

  final Rxn<Face> detectedFace = Rxn<Face>();

  Timer? _throttleTimer;

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        selectedCamera!,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();

      isCameraInitialized.value = true;
      statusMessage.value = 'Camera ready';
      await startImageStream();
    } catch (e) {
      statusMessage.value = 'Camera initialization failed: $e';
    }
  }

  Future<void> startImageStream() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (cameraController!.value.isStreamingImages) return;

    await cameraController!.startImageStream((CameraImage image) {
      if (isProcessingFrame.value) return;

      if (_throttleTimer?.isActive ?? false) return;

      _throttleTimer = Timer(const Duration(milliseconds: 150), () {});
      _processFrame(image);
    });

    isStreaming.value = true;
  }

  Future<void> stopImageStream() async {
    if (cameraController != null && cameraController!.value.isStreamingImages) {
      await cameraController!.stopImageStream();
    }
    isStreaming.value = false;
  }

  Future<void> _processFrame(CameraImage image) async {
    if (cameraController == null || selectedCamera == null) return;

    try {
      isProcessingFrame.value = true;

      final inputImage = InputImageConverter.fromCameraImage(
        image: image,
        camera: selectedCamera!,
      );

      if (inputImage == null) {
        statusMessage.value = 'Unsupported image format';
        _resetFaceState();
        return;
      }

      final faces = await faceDetectionService.detectFaces(inputImage);

      if (faces.isEmpty) {
        _resetFaceState(message: 'No face detected');
        return;
      }

      isFaceDetected.value = true;
      isSingleFace.value = faces.length == 1;

      if (faces.length > 1) {
        detectedFace.value = null;
        isFaceCentered.value = false;
        isCaptureEnabled.value = false;
        statusMessage.value = 'Multiple faces detected';
        return;
      }

      final face = faces.first;
      detectedFace.value = face;

      _validateFace(face, image.width.toDouble(), image.height.toDouble());
    } catch (e) {
      _resetFaceState(message: 'Detection failed: $e');
    } finally {
      isProcessingFrame.value = false;
    }
  }

  void _validateFace(Face face, double imageWidth, double imageHeight) {
    final box = face.boundingBox;

    final faceCenterX = box.left + (box.width / 2);
    final faceCenterY = box.top + (box.height / 2);

    final imageCenterX = imageWidth / 2;
    final imageCenterY = imageHeight / 2;

    final dx = (faceCenterX - imageCenterX).abs();
    final dy = (faceCenterY - imageCenterY).abs();

    final centeredX = dx < imageWidth * 0.18;
    final centeredY = dy < imageHeight * 0.18;

    isFaceCentered.value = centeredX && centeredY;

    final leftEyeProb = face.leftEyeOpenProbability ?? 0.0;
    final rightEyeProb = face.rightEyeOpenProbability ?? 0.0;

    isLeftEyeOpen.value = leftEyeProb > 0.5;
    isRightEyeOpen.value = rightEyeProb > 0.5;

    final valid =
        isFaceDetected.value && isSingleFace.value && isFaceCentered.value;

    isCaptureEnabled.value = valid;

    if (!isFaceCentered.value) {
      statusMessage.value = 'Move your face to the center';
    } else if (!isLeftEyeOpen.value || !isRightEyeOpen.value) {
      statusMessage.value = 'Keep both eyes visible';
    } else {
      statusMessage.value = 'Face detected successfully';
    }
  }

  void _resetFaceState({String message = 'No face'}) {
    isFaceDetected.value = false;
    isSingleFace.value = false;
    isFaceCentered.value = false;
    isLeftEyeOpen.value = false;
    isRightEyeOpen.value = false;
    isCaptureEnabled.value = false;
    detectedFace.value = null;
    statusMessage.value = message;
  }

  Future<XFile?> capturePhoto() async {
    if (cameraController == null) return null;
    if (!isCaptureEnabled.value) return null;

    try {
      await stopImageStream();
      final file = await cameraController!.takePicture();
      statusMessage.value = 'Photo captured';
      return file;
    } catch (e) {
      statusMessage.value = 'Capture failed: $e';
      return null;
    } finally {
      await startImageStream();
    }
  }

  @override
  Future<void> onClose() async {
    _throttleTimer?.cancel();
    await stopImageStream();
    await cameraController?.dispose();
    faceDetectionService.dispose();
    super.onClose();
  }
}
