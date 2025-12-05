import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';

class OnboardController extends GetxController {
  /// State variables
  RxBool isEnable = false.obs;
  var selectedIndex = RxnInt();
  var selectedImageIndex = RxnInt();
  RxBool isSwitchOn = true.obs;
  RxBool isNotFeet = false.obs;
  RxBool isDateSelected = false.obs;
  RxInt selectedIndexDate = 0.obs;
  RxBool isHumanProccessing = false.obs;
  RxBool isHumanProccessingStep2 = false.obs;
  RxBool isFaceRecognigation = false.obs;
  RxList<int> selectedDates = <int>[].obs;
  Rx<File?> imageFile = Rx<File?>(null);

  /// Text controllers
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();

  /// Face detection related
  Rx<File?> faceImage = Rx<File?>(null);
  Rx<File?> postureImage = Rx<File?>(null);
  Rx<Face?> detectedFace = Rx<Face?>(null);
  Rx<ui.Size?> imageSize = Rx<ui.Size?>(null);

  final FaceDetectionService _faceService = FaceDetectionService();

  /// Multi-image handling
  RxList<Rx<File?>> fileList = List.generate(6, (_) => Rx<File?>(null)).obs;

  void updateFile(int index, File file) {
    if (index < fileList.length) {
      fileList[index].value = file;
      fileList.refresh(); // ensure UI updates
    }
  }

  void removeFile(int index) {
    if (index < fileList.length) {
      fileList[index].value = null;
      fileList.refresh();
    }
  }

  void toggleSwitch(bool value) => isSwitchOn.value = value;
  void toggleDateSwitch(bool value) {
    isSwitchOn.value = value;

    if (value) {
      selectedDates.value = List.generate(
        OnboardHalper.dateList.length,
        (i) => i,
      );
    } else {
      selectedDates.clear();
    }
  }

  void toggleSelection(int index) {
    selectedIndex.value = (selectedIndex.value == index) ? null : index;
  }

  void toggleDateSelection(int index) {
    if (selectedDates.contains(index)) {
      selectedDates.remove(index);
    } else {
      selectedDates.add(index);
    }
  }

  final ImageUploadServices _imageService = ImageUploadServices();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  // 🔹 Reactive states

  RxBool isProcessing = false.obs;

  // ---------------------------------------------------------------------------
  // IMAGE SELECTION METHODS
  // ---------------------------------------------------------------------------

  /// Capture image from camera and detect face
  Future<void> pickImageFromCamera() async {
    try {
      isProcessing.value = true;
      final imageFile = await _imageService.getImageFromCamera();

      if (imageFile != null) {
        faceImage.value = imageFile;
        await detectFaceFromImage(imageFile);
        Future.delayed(Duration(seconds: 1), () {
          isFaceRecognigation.value = true;
        });
        Future.delayed(Duration(seconds: 3), () {
          isHumanProccessing.value = true;
        });
        Future.delayed(Duration(seconds: 6), () {
          isHumanProccessingStep2.value = true;
        });
      } else {
        Get.snackbar("Error", "No image captured");
      }
    } catch (e) {
      Get.snackbar("Error", "Camera failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> pickImageFromCameraForPosture() async {
    try {
      isProcessing.value = true;
      final imageFile = await _imageService.getImageFromCamera();

      if (imageFile != null) {
        postureImage.value = imageFile;
        // await detectFaceFromImage(imageFile);
        // Future.delayed(Duration(seconds: 1), () {
        //   isFaceRecognigation.value = true;
        // });
        // Future.delayed(Duration(seconds: 3), () {
        //   isHumanProccessing.value = true;
        // });
        // Future.delayed(Duration(seconds: 6), () {
        //   isHumanProccessingStep2.value = true;
        // });
      } else {
        Get.snackbar("Error", "No image captured");
      }
    } catch (e) {
      Get.snackbar("Error", "Camera failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  /// Pick image from gallery and detect face
  Future<void> pickImageFromGallery() async {
    try {
      isProcessing.value = true;
      final imageFile = await _imageService.getImageFromGallery();

      if (imageFile != null) {
        await detectFaceFromImage(imageFile);
      } else {
        Get.snackbar("Error", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", "Gallery failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // FACE DETECTION LOGIC
  // ---------------------------------------------------------------------------

  Future<void> detectFaceFromImage(File imageFile) async {
    try {
      faceImage.value = imageFile;
      detectedFace.value = null;
      imageSize.value = null;

      final inputImage = InputImage.fromFile(imageFile);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        detectedFace.value = faces.first;
      } else {
        Get.snackbar("No Face Detected", "Try again with better lighting.");
      }

      final decodedImage = await decodeImageFromList(
        await imageFile.readAsBytes(),
      );
      imageSize.value = Size(
        decodedImage.width.toDouble(),
        decodedImage.height.toDouble(),
      );
    } catch (e) {
      Get.snackbar("Error", "Face detection failed: $e");
    }
  }

  // Legacy methods for backward compatibility
  Future<void> loadImageSize(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      imageSize.value = Size(
        frame.image.width.toDouble(),
        frame.image.height.toDouble(),
      );
    } catch (e) {
      print('Error loading image size: $e');
    }
  }

  Future<void> analyzeFace(File image) async {
    Future.delayed(Duration(seconds: 2), () async {
      detectedFace.value = await _faceService.detectPrimaryFace(image);
    });
  }

  void resetData() {
    faceImage.value = null;
    detectedFace.value = null;
    imageSize.value = null;
  }

  @override
  void onClose() {
    _faceDetector.close();
    _faceService.dispose();
    super.onClose();
  }
}
