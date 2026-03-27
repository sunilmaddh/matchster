import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/extentions/onboard_pages_ext.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/modules/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/modules/auth/models/otp_verification_response.dart';
import 'package:matchster/features/modules/auth/models/reverse_geocode_response.dart';
import 'package:matchster/features/modules/auth/repositories/onboarding_repository.dart';
import 'package:matchster/features/modules/auth/services/face_detection_service.dart';
import 'package:matchster/features/modules/auth/views/onboarding/current_loading_screen.dart';
import 'package:matchster/features/modules/home/view/landing_screen.dart';
import 'package:matchster/features/modules/profile/services/location_services.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class OnboardController extends GetxController {
  OnboardController({
    required this.onboardingRepository,
    required this.faceDetectionService,
    required this.imageService,
    required this.locationService,
  });

  final OnboardingRepository onboardingRepository;
  final FaceDetectionService faceDetectionService;
  final ImageUploadServices imageService;
  final LocationService locationService;

  /// ----------------------------
  /// UI / STATE
  /// ----------------------------
  final isEnable = false.obs;
  final selectedIndex = RxnInt();
  final selectedImageIndex = RxnInt();

  final isDateWithSwitchOn = false.obs;
  final isSwitchOn = false.obs;
  final isNotFeet = false.obs;
  final isDateSelected = false.obs;
  final selectedIndexDate = 0.obs;

  final isHumanProcessing = false.obs;
  final isHumanProcessingStep2 = false.obs;
  final isFaceRecognition = false.obs;
  final isImageUploading = false.obs;
  final isNextPageEnable = false.obs;
  final isPageLoading = false.obs;
  final isSelectingImage = false.obs;
  final isBottomSheetOpen = false.obs;
  final isProcessing = false.obs;
  final isButtonEnabled = false.obs;

  final selectedDates = <int>[].obs;
  final imageFile = "".obs;
  final dateWithList = <String>[].obs;
  final selectedGender = "".obs;
  final genderPreview = false.obs;
  final selectedDob = "".obs;
  final feet = 0.0.obs;
  final cm = 0.0.obs;
  final selectedDateWith = "".obs;
  final gridImage = "".obs;

  final isNameValid = false.obs;
  final isGenderSelected = false.obs;
  final isDobSelected = false.obs;
  final isHeightSelected = false.obs;
  final isDateSelectedP = false.obs;
  final isPhotoAdded = false.obs;

  final faceImage = Rx<File?>(null);
  final postureImage = Rx<File?>(null);
  final detectedFace = Rx<Face?>(null);
  final imageSize = Rx<ui.Size?>(null);

  final fileList = List.generate(6, (_) => '').obs;
  final stepStatus = <bool>[].obs;

  final nameController = TextEditingController();
  final dobController = ''.obs;
  final heightController = "".obs;
  final currentIndex = ValueNotifier<int>(0);

  late PageController pageController;

  Placemark place = Placemark();

  final isFaceValid = false.obs;
  final showPhotoReview = false.obs;
  File? failedImage;
  int? failedIndex;

  /// ----------------------------
  /// LIFECYCLE
  /// ----------------------------
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    nameController.dispose();
    currentIndex.dispose();
    pageController.dispose();
    faceDetectionService.dispose();
    super.onClose();
  }

  /// ----------------------------
  /// FILE / IMAGE
  /// ----------------------------
  void updateFile(int index, String imageUrl) {
    if (index >= 0 && index < fileList.length) {
      fileList[index] = imageUrl;
      fileList.refresh();
      isPhotoAdded.value = fileList.any((e) => e.isNotEmpty);
      updateButtonState();
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      isProcessing.value = true;
      final file = await imageService.getImageFromCamera();

      if (file == null) {
        Get.snackbar("Error", "No image captured");
        return;
      }

      faceImage.value = file;
      await detectFaceFromImage(file);

      Future.delayed(const Duration(seconds: 1), () {
        isFaceRecognition.value = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        isHumanProcessing.value = true;
      });

      Future.delayed(const Duration(seconds: 6), () {
        isHumanProcessingStep2.value = true;
      });
    } catch (e) {
      Get.snackbar("Error", "Camera failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> pickImageFromCameraForPosture() async {
    try {
      isProcessing.value = true;
      final file = await imageService.getImageFromCamera();

      if (file == null) {
        Get.snackbar("Error", "No image captured");
        return;
      }

      postureImage.value = file;
    } catch (e) {
      Get.snackbar("Error", "Camera failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      isProcessing.value = true;
      final file = await imageService.getImageFromGallery();

      if (file == null) {
        Get.snackbar("Error", "No image selected");
        return;
      }

      faceImage.value = file;
      await detectFaceFromImage(file);
    } catch (e) {
      Get.snackbar("Error", "Gallery failed: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> detectFaceFromImage(File file) async {
    try {
      faceImage.value = file;
      detectedFace.value = null;
      imageSize.value = null;

      detectedFace.value = await faceDetectionService.detectPrimaryFace(file);

      if (detectedFace.value == null) {
        return;
      }

      await loadImageSize(file);
    } catch (e) {
      // Get.snackbar("Error", "Face detection failed: $e");
    }
  }

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
    Future.delayed(const Duration(seconds: 2), () async {
      detectedFace.value = await faceDetectionService.detectPrimaryFace(image);
    });
  }

  void resetData() {
    faceImage.value = null;
    postureImage.value = null;
    detectedFace.value = null;
    imageSize.value = null;
  }

  Future<bool> isFaceClear(File image) async {
    try {
      return await faceDetectionService.isFaceClear(image);
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      return false;
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
        failedImage = file;
        failedIndex = index;
        showPhotoReview.value = true;
        AppNavigation.back();
        return;
      }

      final success = await uploadPhoto(imagePath: file.path, index: index);

      isImageUploading(false);

      if (success) {
        AppNavigation.back();
      }
    } catch (e) {
      isImageUploading(false);
    }
  }

  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
    genderPreview.value = value;
  }

  void toggleDateSwitch(bool value) {
    isDateWithSwitchOn.value = value;

    if (value) {
      selectedDates.value = List.generate(
        OnboardHalper.dateList.length,
        (i) => i,
      );
      dateWithList.assignAll(OnboardHalper.dateList);
      isDateSelectedP.value = true;
    } else {
      selectedDates.clear();
      dateWithList.clear();
      isDateSelectedP.value = false;
    }

    updateButtonState();
  }

  void toggleSelection(int index) {
    isGenderSelected.value = true;
    selectedIndex.value = selectedIndex.value == index ? null : index;

    if (selectedIndex.value != null) {
      selectedGender.value = OnboardHalper.radioList[selectedIndex.value!];
    } else {
      selectedGender.value = '';
      isGenderSelected.value = false;
    }

    updateButtonState();
  }

  void toggleDateSelection(int index) {
    final value = OnboardHalper.dateList[index];

    if (selectedDates.contains(index)) {
      selectedDates.remove(index);
      dateWithList.remove(value);
    } else {
      selectedDates.add(index);
      dateWithList.add(value);
    }

    isDateSelectedP.value = dateWithList.isNotEmpty;
    updateButtonState();
  }

  void enableButton() {
    isEnable.value = nameController.text.trim().isNotEmpty;
  }

  void updateButtonState() {
    switch (currentIndex.value) {
      case 0:
        isButtonEnabled.value = isNameValid.value;
        break;
      case 1:
        isButtonEnabled.value = isGenderSelected.value;
        break;
      case 2:
        isButtonEnabled.value = isDobSelected.value;
        break;
      case 3:
        isButtonEnabled.value = isHeightSelected.value;
        break;
      case 4:
        isButtonEnabled.value = isDateSelectedP.value;
        break;
      case 5:
        isButtonEnabled.value = isPhotoAdded.value;
        break;
      default:
        isButtonEnabled.value = false;
    }
  }

  void updateStepState() {
    if (currentIndex.value >= 0 && currentIndex.value < stepStatus.length) {
      stepStatus[currentIndex.value] = false;
    }
  }

  void goToNextPage() {
    isNextPageEnable.value = true;
  }

  /// ----------------------------
  /// API METHODS
  /// ----------------------------
  Future<bool> addName({required String name}) async {
    try {
      isPageLoading.value = true;
      final response = await onboardingRepository.addName(name: name);
      if (!response.success) {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<bool> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    try {
      isPageLoading.value = true;
      final response = await onboardingRepository.addGender(
        gender: gender,
        genderPreview: genderPreview,
      );

      if (!response.success) {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<bool> addDob({required String dob}) async {
    try {
      isPageLoading.value = true;
      final response = await onboardingRepository.addDob(dob: dob);

      if (!response.success) {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<bool> addHeight({required double feet, required double cm}) async {
    try {
      isPageLoading.value = true;
      final response = await onboardingRepository.addHeight(feet: feet, cm: cm);

      if (!response.success) {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<bool> addDateWith({required List<String> dateWith}) async {
    try {
      isPageLoading.value = true;
      final response = await onboardingRepository.addDateWith(
        dateWith: dateWith,
      );

      if (!response.success) {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        return false;
      }
      goToNextPage();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<bool> uploadPhoto({
    required String imagePath,
    required int index,
  }) async {
    try {
      final response = await onboardingRepository.uploadUserPhoto(
        imagePath: imagePath,
      );

      if (response == null || !response.success) {
        if (Get.isOverlaysOpen || Get.key.currentState?.canPop() == true) {
          Get.back();
        }
        return false;
      }

      final imageUrl = response.data?.url ?? '';
      updateFile(index, imageUrl);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> allOfFame({required List<String> imageUrlList}) async {
    try {
      isPageLoading.value = true;
      final cleanedList = imageUrlList.where((e) => e.isNotEmpty).toList();

      final response = await onboardingRepository.allOfFame(
        imageListUrl: cleanedList,
      );

      return response.success;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
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
      isPageLoading.value = true;

      final response = await onboardingRepository.addCurrentLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );

      return response.success;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isPageLoading.value = false;
    }
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
      await onboardingRepository.addHomeLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<bool> submitStep(int index) async {
    try {
      switch (OnboardHalper.steps[index]) {
        case OnboardStep.name:
          return await addName(name: nameController.text.trim());

        case OnboardStep.gender:
          return await addGender(
            gender: selectedGender.value.toLowerCase(),
            genderPreview: genderPreview.value,
          );

        case OnboardStep.dob:
          return await addDob(dob: selectedDob.value);

        case OnboardStep.height:
          return await addHeight(feet: feet.value, cm: cm.value);

        case OnboardStep.dateWith:
          return await addDateWith(dateWith: dateWithList.toList());

        case OnboardStep.allOfame:
          return await allOfFame(imageUrlList: fileList.toList());
      }
    } catch (e) {
      debugPrint("submitStep error: $e");
      return false;
    }
  }

  /// ----------------------------
  /// PREFILL EXISTING DATA
  /// ----------------------------
  Future<void> setPagesValue(PageValues pagesValue) async {
    /// NAME
    if (pagesValue.name != null && pagesValue.name!.isNotEmpty) {
      nameController.text = pagesValue.name!;
      isNameValid.value = true;
    } else {
      isNameValid.value = false;
    }

    /// GENDER
    if (pagesValue.gender != null && pagesValue.gender!.isNotEmpty) {
      selectedGender.value = pagesValue.gender!;
      isGenderSelected.value = true;

      final list = OnboardHalper.radioList;
      for (int i = 0; i < list.length; i++) {
        if (list[i].contains(selectedGender.value)) {
          selectedIndex.value = i;
          break;
        }
      }
    }

    /// DOB
    if (pagesValue.dob != null && pagesValue.dob!.isNotEmpty) {
      final dateValue = AppMethods.formatFromIso(pagesValue.dob!);
      dobController.value = dateValue['ui'] ?? '';
      selectedDob.value = dateValue['api'] ?? '';
      isDobSelected.value = true;
    }

    /// DATE WITH
    if (pagesValue.dateWith != null && pagesValue.dateWith!.isNotEmpty) {
      dateWithList
        ..clear()
        ..addAll(pagesValue.dateWith!);

      selectedDates.clear();
      final list = OnboardHalper.dateList;

      for (int i = 0; i < list.length; i++) {
        if (dateWithList.contains(list[i])) {
          selectedDates.add(i);
        }
      }

      isDateSelected.value = true;
      isDateSelectedP.value = dateWithList.isNotEmpty;
      isDateWithSwitchOn.value =
          dateWithList.length == list.length &&
          dateWithList.every((e) => list.contains(e));
    }

    /// HEIGHT
    if (pagesValue.height != null && pagesValue.height!.feet != null) {
      final double heightValue = pagesValue.height!.feet!;
      final int feetPart = heightValue.floor();
      final int inchPart = ((heightValue - feetPart) * 10).round();

      heightController.value = "$feetPart feet $inchPart inch";
      feet.value = feetPart.toDouble();
      cm.value = pagesValue.height!.cm ?? 0.0;
      isHeightSelected.value = true;
    }

    /// PHOTOS
    if (pagesValue.hallOfFame != null && pagesValue.hallOfFame!.isNotEmpty) {
      isPhotoAdded.value = true;
    } else {
      isPhotoAdded.value = false;
    }
    updateButtonState();
  }

  Future<void> setOnboardPages(OnboardPages pages) async {
    stepStatus.assignAll(pages.toStepStatusList());
    pageController.dispose();
    pageController = PageController(initialPage: firstIncompleteIndex);
  }

  bool get allCompleted => stepStatus.every((e) => e);

  int get firstIncompleteIndex {
    final index = stepStatus.indexWhere((e) => e == false);
    final result = index == -1 ? 0 : index;
    currentIndex.value = result;
    return result;
  }

  int get nextIncompleteIndex {
    return stepStatus.indexWhere((e) => e == false);
  }

  Future<void> completeStep(int index) async {
    if (index < 0 || index >= stepStatus.length) return;
    stepStatus[index] = true;
    AppMethods.appPrint(message: stepStatus.toString());
    _goToNextStepOrFinish();
  }

  void _goToNextStepOrFinish() {
    final nextIndex = nextIncompleteIndex;

    if (nextIndex == -1) {
      AppNavigation.off(AppRoutes.currentLoadingScreen);
    } else {
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    currentIndex.value = nextIndex == -1 ? currentIndex.value : nextIndex;
    updateButtonState();
  }

  bool get isOnboardingCompleted => !stepStatus.contains(false);

  Future<void> onboardingCompleted() async {
    final position = await fetchLocation();
    if (position == null) return;

    final address = await getAddress(
      lat: position.latitude,
      lng: position.longitude,
    );

    if (address == null) return;

    final isSuccess = await currentLocation(
      lat: address.lat ?? 0.0,
      lng: address.lng ?? 0.0,
      label: address.placeDetails?.label ?? '',
      city: address.placeDetails?.city ?? '',
      state: address.placeDetails?.state ?? '',
      country: address.placeDetails?.country ?? '',
    );
    if (isSuccess) {
      AppNavigation.offAll(AppRoutes.landingScreen);
    }
  }

  Future<Position?> fetchLocation() async {
    try {
      return await locationService.getCurrentLocation();
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
      final response = await onboardingRepository.getAddress(
        lat: lat,
        lng: lng,
      );

      if (response.success) {
        return response.data?.address;
      }

      return null;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      return null;
    }
  }

  Future<void> getLocation() async {
    try {
      final position = await fetchLocation();
      if (position == null) return;

      final address = await getAddress(
        lat: position.latitude,
        lng: position.longitude,
      );
      if (address == null) return;
      await currentLocation(
        lat: address.lat ?? 0.0,
        lng: address.lng ?? 0.0,
        label: address.placeDetails?.label ?? '',
        city: address.placeDetails?.city ?? '',
        state: address.placeDetails?.state ?? '',
        country: address.placeDetails?.country ?? '',
      );
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }
}
