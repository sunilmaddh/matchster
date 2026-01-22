import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/extentions/onboard_pages_ext.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/navigation_helper.dart';
import 'package:matchster/features/moduls/auth/login/models/otp_verification_response.dart';
import 'package:matchster/features/moduls/auth/login/models/reverse_geocode_response.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/onboard/services/onboard_service.dart';
import 'package:matchster/features/moduls/auth/onboard/view/current_loading_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/view/photo_preview_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/photo_review_bottomsheet.dart';
import 'package:matchster/features/moduls/home/view/landing_screen.dart';
import 'package:matchster/features/moduls/profile/services/location_services.dart'
    show LocationService;

class OnboardController extends GetxController {
  final OnboardService _onboardService = OnboardService();

  /// State variables
  RxBool isEnable = false.obs;
  var selectedIndex = RxnInt();
  var selectedImageIndex = RxnInt();
  RxBool isSwitchOn = false.obs;
  RxBool isNotFeet = false.obs;
  RxBool isDateSelected = false.obs;
  RxInt selectedIndexDate = 0.obs;
  RxBool isHumanProccessing = false.obs;
  RxBool isHumanProccessingStep2 = false.obs;
  RxBool isFaceRecognigation = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isNextPageEnable = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool isSelectingImage = false.obs;

  RxList<int> selectedDates = <int>[].obs;
  RxString imageFile = "".obs;

  /// Text controllers
  final nameController = TextEditingController();
  RxString dobController = ''.obs;
  RxString heightController = "".obs;
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

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
  RxString gridImage = "".obs;
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

  RxList<String> fileList = List.generate(6, (_) => '').obs;
  void updateFile(int index, String imageUrl) {
    if (index < fileList.length) {
      fileList[index] = imageUrl;
      fileList.refresh();
      isEnable.value = true;
      // if (index == fileList.length - 1) isEnable.value = true;
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
      isEnable.value = true;
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
      isEnable.value = true;
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

  RxBool isProcessing = false.obs;

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
    faceDetector.close(); // 🔴 VERY IMPORTANT
    super.onClose();
  }

  Future<bool> addName({required String name}) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addName(name: name);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        goToNextPage();
        return true;
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isPageLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPageLoading(false);
      return false;
    } finally {
      isPageLoading(false);
    }
  }

  Future<bool> addGender({
    required String gender,
    required genderPreview,
  }) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addGender(
        gender: gender,
        genderPreview: genderPreview,
      );
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        goToNextPage();
        isPageLoading(false);
        return true;
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isPageLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPageLoading(false);
      return false;
    } finally {
      isPageLoading(false);
    }
  }

  Future<bool> addDob({required String dob}) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addDob(dob: dob);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        goToNextPage();
        isPageLoading(false);
        return true;
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isPageLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addHieght({required double feet, required double cm}) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addHieght(feet: feet, cm: cm);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        goToNextPage();
        isPageLoading(false);
        return true;
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isPageLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPageLoading(false);
      return false;
    } finally {
      isPageLoading(false);
    }
  }

  Future<bool> addDatewith({required List dateWith}) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addDateWith(dateWith: dateWith);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        goToNextPage();
        isPageLoading(false);
        return true;
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isPageLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPageLoading(false);
      return false;
    } finally {
      isPageLoading(false);
    }
  }

  Future<bool> uploadPhotoW({
    required String imagePath,
    required int index,
  }) async {
    try {
      final response = await _onboardService.uploadImageWithDio(imagePath);
      if (response!.success) {
        final image = response.data!.url ?? '';
        updateFile(index, image.toString());

        return true;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> allOfFame({required List<String> imageUrlList}) async {
    try {
      isPageLoading(true);
      final cleanedList = imageUrlList.where((e) => e.isNotEmpty).toList();
      final response = await _onboardService.allOfFame(
        imageUrlList: cleanedList,
      );
      if (response.success) {
        AppToastMessage.show(
          title: "Success",
          message: "Success ${response.success}",
        );
        isPageLoading(false);
        return true;
      } else {
        isPageLoading(false);
        AppToastMessage.show(
          title: "Error",
          message: "Success ${response.message}",
        );
      }
    } catch (e) {
      isPageLoading(false);
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> currentLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      isPageLoading(true);
      final response = await _onboardService.addCurrentLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );
      if (response.success) {
        isPageLoading(false);
        AppToastMessage.show(
          title: "Success",
          message: "Success ${response.success}",
        );

        return true;
      }
    } catch (e) {
      isPageLoading(false);
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> submitStep(int index) async {
    try {
      switch (OnboardHalper.steps[index]) {
        case OnboardStep.name:
          return await addName(name: nameController.text);

        case OnboardStep.gender:
          return await addGender(
            gender: selectedGender.value.toLowerCase(),
            genderPreview: genderPreview.value,
          );

        case OnboardStep.dob:
          return await addDob(dob: selectedDob.value);

        case OnboardStep.height:
          return await addHieght(feet: feet.value, cm: cm.value);

        case OnboardStep.dateWith:
          return await addDatewith(dateWith: dateWithList);
        case OnboardStep.allOfame:
          return await allOfFame(imageUrlList: fileList);
      }
    } catch (e) {
      debugPrint("submitStep error: $e");
      return false;
    }
  }

  void goToNextPage() {
    isNextPageEnable.value = true;
  }

  RxList<bool> stepStatus = <bool>[].obs;
  // late PageController pageController;
  late PageController pageController = PageController(
    initialPage: firstIncompleteIndex,
  );

  Future<void> setOnboardPages(OnboardPages pages) async {
    stepStatus.assignAll(pages.toStepStatusList());
    pageController = PageController(initialPage: firstIncompleteIndex);
  }

  bool get allCompleted => stepStatus.every((e) => e);
  int get firstIncompleteIndex {
    final index = stepStatus.indexWhere((e) => e == false);
    return index == -1 ? 0 : index;
  }

  // Future<void> completeStep(int index) async {
  //   if (index < 0 || index >= stepStatus.length) return;
  //   stepStatus[index] = true;
  // }

  int get nextIncompleteIndex {
    return stepStatus.indexWhere((e) => e == false);
  }

  Future<void> completeStep(int index) async {
    AppToastMessage.show(title: 'Step Status', message: stepStatus.toString());
    if (index < 0 || index >= stepStatus.length) return;

    stepStatus[index] = true;
    AppMethods.appPrint(message: stepStatus.toString());
    AppToastMessage.show(title: 'Step Status', message: stepStatus.toString());

    _goToNextStepOrFinish();
  }

  void _goToNextStepOrFinish() {
    final nextIndex = nextIncompleteIndex;

    if (nextIndex == -1) {
      Get.off(CurrentLoadingScreen());
    } else {
      // ➡️ Move to next incomplete page
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    currentIndex.value = nextIndex;
  }

  void onboardingCompleted() async {
    final Position? position = await fetchLocation();
    if (position != null) {
      final address = await getAddress(
        lat: position.latitude,
        lng: position.longitude,
      );
      final isSuccess = await currentLocation(
        lat: address!.lat!,
        lng: address.lng!,
        label: address.placeDetails!.label!,
        city: address.placeDetails!.city!,
        state: address.placeDetails!.state!,
        country: address.placeDetails!.country!,
      );
      if (isSuccess) {
        Get.offAll(() => const LandingScreen());
      }
    }
  }

  bool get isOnboardingCompleted {
    return !stepStatus.contains(false);
  }

  final LocationService _locationService = LocationService();
  Placemark place = Placemark();
  Future<Position?> fetchLocation() async {
    try {
      Position? position = await _locationService.getCurrentLocation();
      return position!;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      return null;
    }
  }

  Future<Address?> getAddress({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _onboardService.getAddress(lat: lat, lng: lng);
      if (response.success) {
        AppMethods.appPrint(
          message:
              "Api location data    ${response.data!.address.placeDetails!.country},${response.data!.address.placeDetails!.label},${response.data!.address.placeDetails!.city} ",
        );
        return response.data!.address;
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      return null;
    }
    return null;
  }

  Future<void> addHomeLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      final response = await _onboardService.addHomeLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );
      if (response.success) {}
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> getLocation() async {
    try {
      Position? position = await fetchLocation();
      if (position != null) {
        final address = await getAddress(
          lat: position.latitude,
          lng: position.longitude,
        );
        final isSuccess = await currentLocation(
          lat: address!.lat!,
          lng: address.lng!,
          label: address.placeDetails!.label!,
          city: address.placeDetails!.city!,
          state: address.placeDetails!.state!,
          country: address.placeDetails!.country!,
        );
      }

      AppMethods.appPrint(
        message:
            "Location data ${position!.latitude}${position.longitude} ${place.country}${place.locality},${place.administrativeArea},${place.name}",
      );
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<bool> isFaceClear(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faces = await faceDetector.processImage(inputImage);

    // ❌ No face or multiple faces
    if (faces.length != 1) return false;

    final face = faces.first;

    // ❌ Eyes closed
    if ((face.leftEyeOpenProbability ?? 0) < 0.5 ||
        (face.rightEyeOpenProbability ?? 0) < 0.5) {
      return false;
    }

    // ❌ Face turned too much
    if ((face.headEulerAngleY ?? 0).abs() > 15 ||
        (face.headEulerAngleZ ?? 0).abs() > 15) {
      return false;
    }

    return true; // ✅ Clear face
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

        if (Get.isOverlaysOpen || Get.key.currentState?.canPop() == true) {
          Get.back();
        }

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back();
            Get.to(PhotoPreviewScreen(imageFile: selectedImage, index: index));
          },
        );
        return;
      }

      final success = await uploadPhotoW(imagePath: file.path, index: index);

      isImageUploading(false);

      if (success) {
        Get.back();
      }
    } catch (e) {
      isImageUploading(false);
      AppMethods.appPrint(message: e.toString());
    }
  }
}
