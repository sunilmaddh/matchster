import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/posture/repositories/i_posture_repository.dart';
import 'package:matchster/main.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class PostureController extends BaseController {
  PostureController({required this.repository});

  final IPostureRepository repository;

  final Rx<GestureStep> currentStep = GestureStep.detectVictory.obs;
  final RxInt postureIndex = 0.obs;

  final List<String> postureList = [
    AppAssets.posture1,
    AppAssets.posture2,
    AppAssets.posture3,
  ];

  final RxBool isCameraInitialized = false.obs;
  final RxBool isInitialized = false.obs;
  final RxBool isPostureVerify = false.obs;
  final RxBool isDetecting = false.obs;
  final RxBool isCapturing = false.obs;
  final RxBool showCameraLoader = true.obs;

  final RxBool isFaceDetected = false.obs;
  final RxBool isFaceValid = false.obs;
  final RxBool isGestureValid = false.obs;

  final RxString faceStatus = ''.obs;
  final RxString gestureStatus = ''.obs;
  final RxString combinedStatus = ''.obs;

  final RxList<Hand> handsLand = <Hand>[].obs;
  final RxnString lastCapturedPath = RxnString();

  int _stableFrames = 0;
  final int requiredFrames = 5;

  CameraController? get cameraController => repository.cameraService.controller;

  bool get isCameraReady =>
      repository.cameraService.isReady && isInitialized.value;

  Future<void> initialize() async {
    try {
      showCameraLoader.value = true;

      final CameraDescription camera = camerasList.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => camerasList.first,
      );

      await repository.initialize(camera);
      await repository.startImageStream(processCameraImage);

      isInitialized.value = true;
      isCameraInitialized.value = true;

      faceStatus.value = AppStrings.postureString.alignFace;
      gestureStatus.value = AppStrings.postureString.showCorrectGesture;
      combinedStatus.value = AppStrings.postureString.faceGestureNotDetected;

      showCameraLoader.value = false;
      update();
    } catch (e) {
      isInitialized.value = false;
      isCameraInitialized.value = false;
      combinedStatus.value =
          AppStrings.postureString.cameraInitializationFailed;
      showCameraLoader.value = false;
      update();
    }
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (_shouldSkipFrame()) return;

    isDetecting.value = true;

    try {
      await _updateFaceState(image);
      await _updateGestureState(image);
      await _handleCaptureFlow();
    } catch (_) {
      combinedStatus.value = AppStrings.postureString.detectionFailed;
    } finally {
      isDetecting.value = false;
    }
  }

  bool _shouldSkipFrame() {
    return isDetecting.value ||
        isCapturing.value ||
        !isInitialized.value ||
        cameraController == null;
  }

  Future<void> _updateFaceState(CameraImage image) async {
    final faceResult = await repository.detectFace(
      image: image,
      sensorOrientation: cameraController!.description.sensorOrientation,
    );

    isFaceDetected.value = faceResult.isFaceDetected;
    isFaceValid.value = faceResult.isFaceValid;
    faceStatus.value = faceResult.status;
  }

  Future<void> _updateGestureState(CameraImage image) async {
    final gestureResult = await repository.detectGesture(
      image: image,
      sensorOrientation: cameraController!.description.sensorOrientation,
      step: currentStep.value,
    );

    isGestureValid.value = gestureResult.isGestureValid;
    gestureStatus.value = gestureResult.status;
    handsLand.assignAll(gestureResult.hands);
  }

  Future<void> _handleCaptureFlow() async {
    if (isFaceValid.value && isGestureValid.value) {
      _stableFrames++;
      combinedStatus.value =
          '${AppStrings.postureString.holdStill} $_stableFrames/$requiredFrames';

      if (_stableFrames >= requiredFrames) {
        _stableFrames = 0;
        combinedStatus.value = AppStrings.postureString.capturing;
        await Future.delayed(const Duration(milliseconds: 300));
        await _captureAndStop();
      }
    } else {
      _stableFrames = 0;
      _updateCombinedStatus();
    }
  }

  Future<void> _captureAndStop() async {
    if (isCapturing.value) return;

    try {
      showLoading(true);
      isCapturing.value = true;
      showCameraLoader.value = true;

      await repository.stopImageStream();

      final XFile? file = await repository.takePicture();
      if (file == null) {
        showCameraLoader.value = false;
        return;
      }

      lastCapturedPath.value = file.path;
      isPostureVerify.value = true;
      combinedStatus.value = AppStrings.postureString.capturedSuccessfully;

      showCameraLoader.value = false;
      AppNavigation.back();
    } catch (_) {
      combinedStatus.value = AppStrings.postureString.captureFailed;
      showCameraLoader.value = false;
    } finally {
      showLoading(false);
      isCapturing.value = false;
    }
  }

  Future<void> restartDetection() async {
    showCameraLoader.value = true;
    _stableFrames = 0;
    isCapturing.value = false;
    isDetecting.value = false;
    isPostureVerify.value = false;
    isGestureValid.value = false;
    lastCapturedPath.value = null;
    handsLand.clear();

    gestureStatus.value = AppStrings.postureString.showCorrectGesture;
    _updateCombinedStatus();

    await repository.startImageStream(processCameraImage);
    await Future.delayed(const Duration(milliseconds: 200));

    showCameraLoader.value = false;
  }

  Future<void> moveToNextStep() async {
    isPostureVerify.value = false;
    isGestureValid.value = false;
    _stableFrames = 0;

    switch (currentStep.value) {
      case GestureStep.detectVictory:
        currentStep.value = GestureStep.detectThumbOnchin;
        postureIndex.value = 1;
        break;
      case GestureStep.detectThumbOnchin:
        currentStep.value = GestureStep.detectOk;
        postureIndex.value = 2;
        break;
      case GestureStep.detectOk:
        currentStep.value = GestureStep.completed;
        break;
      case GestureStep.completed:
        break;
    }

    gestureStatus.value = AppStrings.postureString.showCorrectGesture;
    _updateCombinedStatus();
  }

  Future<void> verifyAndNavigate() async {
    if (isPostureVerify.isTrue) {
      await moveToNextStep();
      await restartDetection();
      return;
    }

    await restartDetection();
    navigateTo(AppRoutes.handTrackerScreen);
  }

  void resetImage() {
    lastCapturedPath.value = null;
  }

  void _updateCombinedStatus() {
    if (!isFaceValid.value && !isGestureValid.value) {
      combinedStatus.value = AppStrings.postureString.faceGestureNotDetected;
    } else if (!isFaceValid.value) {
      combinedStatus.value = faceStatus.value;
    } else if (!isGestureValid.value) {
      combinedStatus.value = gestureStatus.value;
    } else {
      combinedStatus.value = AppStrings.postureString.holdStill;
    }
  }

  @override
  void onClose() {
    repository.dispose();
    super.onClose();
  }
}
