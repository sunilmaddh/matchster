import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/auth/repositories/onboard_repository.dart';
import 'package:matchster/features/auth/view/onboard/photo_preview_screen.dart';
import 'package:matchster/features/auth/widgets/photo_review_bottomsheet.dart';

class OnboardPhotoController extends BaseController {
  OnboardPhotoController({
    required this.onboardingRepository,
    required this.faceService,
  });
  final OnboardingRepository onboardingRepository;
  final FaceDetectionService faceService;
  final Rx<File?> faceImage = Rx<File?>(null);
  final Rx<File?> postureImage = Rx<File?>(null);
  final Rx<Face?> detectedFace = Rx<Face?>(null);
  final Rx<ui.Size?> imageSize = Rx<ui.Size?>(null);

  final RxBool isImageUploading = false.obs;
  final RxBool isProcessing = false.obs;
  final RxBool isFaceRecognigation = false.obs;
  final RxBool isHumanProccessing = false.obs;
  final RxBool isHumanProccessingStep2 = false.obs;
  final RxBool isPhotoAdded = false.obs;
  final Rx<File?> previewImage = Rx<File?>(null);
  final RxnInt previewIndex = RxnInt();

  final RxList<String> fileList = List.generate(6, (_) => '').obs;

  late final FaceDetector faceDetector;
  @override
  void onInit() {
    super.onInit();
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableClassification: true,
        enableTracking: false,
        minFaceSize: 0.15,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  void updateFile(int index, String imageUrl) {
    if (index < 0 || index >= fileList.length) return;
    if (imageUrl.trim().isEmpty) return;

    fileList[index] = imageUrl;
    fileList.refresh();
    isPhotoAdded.value = fileList.any((e) => e.isNotEmpty);
  }

  void removeFile(int index) {
    if (index >= 0 && index < fileList.length) {
      fileList[index] = '';
      fileList.refresh();
      isPhotoAdded.value = fileList.any((e) => e.isNotEmpty);
    }
  }

  void setPreviewData({required File file, required int index}) {
    previewImage.value = file;
    previewIndex.value = index;
  }

  Future<void> onCropAndUploadTap({
    required File fileImage,
    required int indexx,
  }) async {
    final file = fileImage;
    final index = indexx;

    if (file == null || index == null) {
      setError('Image not found');
      return;
    }
    try {
      isImageUploading.value = true;
      clearError();
      final croppedFile = await cropImage(file);
      if (croppedFile == null) {
        return;
      }
      previewImage.value = croppedFile;
      await validateAndUploadPhoto(file: croppedFile, index: index);
    } catch (e) {
      setError('Failed to process image');
    } finally {
      isImageUploading.value = false;
    }
  }

  Future<File?> cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          backgroundColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          cropGridColor: Colors.white.withOpacity(0.7),
          cropFrameColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  List<int> getEmptyIndexes() {
    final emptyIndexes = <int>[];
    for (int i = 0; i < fileList.length; i++) {
      if (fileList[i].isEmpty) {
        emptyIndexes.add(i);
      }
    }
    return emptyIndexes;
  }

  Future<bool> isFaceClear(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faces = await faceDetector.processImage(inputImage);

    if (faces.length != 1) return false;

    final face = faces.first;
    final imgSize = await _getImageSize(image);
    final faceRect = face.boundingBox;
    final edgeMargin = faceRect.width * 0.08;

    if (faceRect.left <= edgeMargin ||
        faceRect.top <= edgeMargin ||
        faceRect.right >= imgSize.width - edgeMargin ||
        faceRect.bottom >= imgSize.height - edgeMargin) {
      return false;
    }

    if ((face.leftEyeOpenProbability ?? 1) < 0.5 ||
        (face.rightEyeOpenProbability ?? 1) < 0.5) {
      return false;
    }

    return true;
  }

  Future<Size> _getImageSize(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return Size(frame.image.width.toDouble(), frame.image.height.toDouble());
  }

  Future<bool> uploadPhoto({
    required String imagePath,
    required int index,
  }) async {
    try {
      clearError();

      final response = await onboardingRepository.uploadUserPhoto(
        imagePath: imagePath,
      );

      if (response == null || !response.success) {
        setError(response?.message ?? 'Photo upload failed');
        return false;
      }

      updateFile(index, response.data?.url ?? '');
      return true;
    } catch (e) {
      setError('Photo upload failed');
      return false;
    }
  }

  Future<bool> saveHallOfFame() async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final filterList = fileList.where((e) => e.isNotEmpty).toList();
      final response = await onboardingRepository.allOfFame(
        imageListUrl: filterList,
      );

      if (!response.success) {
        setError(response.message ?? 'Failed to save photos');
        return false;
      }

      setSuccess(response.message ?? 'Photos saved successfully');
      return true;
    } catch (e) {
      setError('Failed to save photos');
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<void> validateAndUploadPhoto({
    required File file,
    required int index,
  }) async {
    try {
      isImageUploading(true);

      final isValid = await isFaceClear(file);

      if (!isValid) {
        isImageUploading(false);

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
        return;
      }

      final success = await uploadPhoto(imagePath: file.path, index: index);
      isImageUploading(false);

      if (success) {
        Get.back(result: {'success': true});
      } else {
        setError("Photo upload failed. Please try again.");
        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
      }
    } catch (e) {
      isImageUploading(false);
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addSelectedFiles(List<File> selectedFiles) async {
    final emptyIndexes = getEmptyIndexes();
    if (emptyIndexes.isEmpty) {
      setError("You can upload only 6 photos");

      return;
    }

    final filesToProcess = selectedFiles.take(emptyIndexes.length).toList();

    for (int i = 0; i < filesToProcess.length; i++) {
      final targetIndex = emptyIndexes[i];
      final file = filesToProcess[i];
      final result = await Get.to<Map<String, dynamic>>(
        () => PhotoPreviewScreen(imageFile: file, index: targetIndex),
      );

      if (result == null) {
        break;
      }
      if (result['retryFile'] != null) {
        final retryFile = result['retryFile'] as File;
        final retryResult = await Get.to<Map<String, dynamic>>(
          () => PhotoPreviewScreen(imageFile: retryFile, index: targetIndex),
        );
        if (retryResult != null && retryResult['success'] == true) {
          final imageUrl = retryResult['imageUrl'] ?? '';
          updateFile(targetIndex, imageUrl);
        }
      }
    }
  }

  @override
  void onClose() {
    faceDetector.close();
    faceService.dispose();
    super.onClose();
  }
}
