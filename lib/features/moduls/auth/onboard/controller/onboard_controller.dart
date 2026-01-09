import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/onboard_pages_ext.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/image_crop.dart';
import 'package:matchster/core/utils/navigation_helper.dart';
import 'package:matchster/features/moduls/auth/login/models/otp_verification_response.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/onboard/services/onboard_service.dart';
import 'package:matchster/features/moduls/auth/onboard/view/photo_preview_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/photo_review_bottomsheet.dart';
import 'package:matchster/features/moduls/home/view/landing_screen.dart';

class OnboardController extends GetxController {
  final OnboardService _onboardService = OnboardService();

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
  RxBool isImageUploading = false.obs;

  RxList<int> selectedDates = <int>[].obs;
  RxString imageFile = "".obs;

  /// Text controllers
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();

  /// Face detection related
  Rx<File?> faceImage = Rx<File?>(null);
  Rx<File?> postureImage = Rx<File?>(null);
  Rx<Face?> detectedFace = Rx<Face?>(null);
  Rx<ui.Size?> imageSize = Rx<ui.Size?>(null);
  RxList<String> dateWithList = <String>[].obs;
  RxString selectedGender = "".obs;
  RxBool genderPreview = false.obs;
  RxString selectedDob = "".obs;
  RxDouble feet = 0.0.obs;
  RxDouble cm = 0.0.obs;
  RxString selectedDateWith = "".obs;
  final FaceDetectionService _faceService = FaceDetectionService();
  RxList<String> fileList = List.generate(6, (_) => '').obs;
  void updateFile(int index, String imageUrl) {
    if (index < fileList.length) {
      fileList[index] = imageUrl;
      fileList.refresh();
    } else {
      isEnable.value = true;
    }
  }

  // void removeFile(int index) {
  //   if (index < fileList.length) {
  //     fileList[index].value = null;
  //     fileList.refresh();
  //   }
  // }

  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
    if (value) {
      genderPreview.value = true;
    } else {
      genderPreview.value = false;
    }
  }

  void toggleDateSwitch(bool value) {
    isSwitchOn.value = value;

    if (value) {
      selectedDates.value = List.generate(
        OnboardHalper.dateList.length,
        (i) => i,
      );
      dateWithList.assignAll(OnboardHalper.dateList);
    } else {
      dateWithList.clear();
      selectedDates.clear();
    }
  }

  void toggleSelection(int index) {
    isEnable.value = true;
    selectedIndex.value = (selectedIndex.value == index) ? null : index;
    selectedGender.value = OnboardHalper.radioList[selectedIndex.value!];
  }

  void toggleDateSelection(int index) {
    if (selectedDates.contains(index)) {
      selectedDates.remove(index);
      dateWithList.remove(OnboardHalper.dateList[index]);
    } else {
      selectedDates.add(index);
      dateWithList.add(OnboardHalper.dateList[index]);
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
      debugPrint(e.toString());
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

  Future<void> addName({required String name}) async {
    try {
      final response = await _onboardService.addName(name: name);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addGender({
    required String gender,
    required genderPreview,
  }) async {
    try {
      final response = await _onboardService.addGender(
        gender: gender,
        genderPreview: genderPreview,
      );
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addDob({required String dob}) async {
    try {
      final response = await _onboardService.addDob(dob: dob);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addHieght({required double feet, required double cm}) async {
    try {
      final response = await _onboardService.addHieght(feet: feet, cm: cm);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addDatewith({required List dateWith}) async {
    try {
      final response = await _onboardService.addDateWith(dateWith: dateWith);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadPhotoW({
    required String imagePath,
    required int index,
  }) async {
    try {
      isImageUploading(true);
      final response = await _onboardService.uploadImageWithDio(imagePath);
      if (response!.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        final image = response.data!.url ?? '';
        updateFile(index, image.toString());
        isImageUploading(false);
        Get.back();
      } else {
        isImageUploading(false);
        Get.back();
        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.to(PhotoPreviewScreen(imageFile: selectedImage, index: index));
          },
        );
      }
    } catch (e) {
      isImageUploading(false);
      debugPrint(e.toString());
    } finally {
      isImageUploading(false);
    }
  }

  Future<void> allOfFame({required List<String> imageUrlList}) async {
    try {
      final response = await _onboardService.allOfFame(
        imageUrlList: imageUrlList,
      );
      if (response.success) {
        NavigationHelper.pushAndRemoveUntil(LandingScreen());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void submitStep(int index) {
    switch (OnboardHalper.steps[index]) {
      case OnboardStep.name:
        addName(name: nameController.text);
        break;

      case OnboardStep.gender:
        addGender(
          gender: selectedGender.value.toLowerCase(),
          genderPreview: genderPreview.value,
        );
        break;

      case OnboardStep.dob:
        addDob(dob: selectedDob.value);
        break;

      case OnboardStep.height:
        addHieght(feet: feet.value, cm: cm.value);
        break;

      case OnboardStep.dateWith:
        addDatewith(dateWith: dateWithList);
        break;
    }
  }

  RxList<bool> stepStatus = <bool>[].obs;
  late PageController pageController;

  void setOnboardPages(OnboardPages pages) {
    stepStatus.assignAll(pages.toStepStatusList());

    pageController = PageController(initialPage: firstIncompleteIndex);
  }

  int get firstIncompleteIndex {
    final index = stepStatus.indexWhere((e) => e == false);
    return index == -1 ? 0 : index;
  }

  void completeStep(int index) {
    if (index < 0 || index >= stepStatus.length) return;
    stepStatus[index] = true;
  }

  int get nextIncompleteIndex {
    return stepStatus.indexWhere((e) => e == false);
  }
}
