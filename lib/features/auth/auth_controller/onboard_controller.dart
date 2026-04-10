import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/extentions/onboard_pages_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/auth/auth_controller/onboard_photo_controller.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/auth/model/response/otp_verification_response.dart';
import 'package:matchster/features/auth/repositories/onboard_repository.dart';
import 'package:matchster/routes/app_routes.dart';

class OnboardController extends BaseController {
  OnboardController({required this.onboardingRepository});

  final OnboardingRepository onboardingRepository;

  final TextEditingController nameController = TextEditingController();
  final RxString dobController = ''.obs;
  final RxString heightController = ''.obs;

  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  late PageController pageController;

  final RxnInt selectedIndex = RxnInt();
  final RxBool isDateWithSwitchOn = false.obs;
  final RxBool isSwitchOn = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxBool isNextPageEnable = false.obs;

  final RxList<int> selectedDates = <int>[].obs;
  final RxList<String> dateWithList = <String>[].obs;
  final RxList<bool> stepStatus = <bool>[].obs;

  final RxString selectedGender = ''.obs;
  final RxBool genderPreview = false.obs;
  final RxString selectedDob = ''.obs;
  final RxDouble feet = 0.0.obs;
  final RxDouble cm = 0.0.obs;
  final RxBool isEnable = false.obs;
  final RxBool isBottomSheetOpen = false.obs;

  final isNameValid = false.obs;
  final isGenderSelected = false.obs;
  final isDobSelected = false.obs;
  final isHeightSelected = false.obs;
  final isDateSelectedP = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void updateStepState() {
    stepStatus[currentIndex.value] = false;
  }

  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
    genderPreview.value = value;
  }

  void toggleSelection(int index) {
    selectedIndex.value = index;
    selectedGender.value = OnboardHalper.radioList[index];
    isGenderSelected.value = true;
    updateButtonState();
  }

  void toggleDateSwitch(bool value) {
    isDateWithSwitchOn.value = value;

    if (value) {
      selectedDates.assignAll(
        List.generate(OnboardHalper.dateList.length, (i) => i),
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

  void toggleDateSelection(int index) {
    if (selectedDates.contains(index)) {
      selectedDates.remove(index);
      dateWithList.remove(OnboardHalper.dateList[index]);
    } else {
      selectedDates.add(index);
      dateWithList.add(OnboardHalper.dateList[index]);
    }

    isDateSelectedP.value = dateWithList.isNotEmpty;
    updateButtonState();
  }

  Future<bool> addName({required String name}) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await onboardingRepository.addName(name: name);

      if (!response.success) {
        setError(response.message);
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await onboardingRepository.addGender(
        gender: gender,
        genderPreview: genderPreview,
      );

      if (!response.success) {
        setError(response.message);
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> addDob({required String dob}) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await onboardingRepository.addDob(dob: dob);

      if (!response.success) {
        setError(response.message);
        return false;
      }
      goToNextPage();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> addHeight({required double feet, required double cm}) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await onboardingRepository.addHeight(feet: feet, cm: cm);

      if (!response.success) {
        setError(response.message);
        return false;
      }
      goToNextPage();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> addDateWith({required List<String> dateWith}) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await onboardingRepository.addDateWith(
        dateWith: dateWith,
      );

      if (!response.success) {
        setError(response.message);
        return false;
      }

      goToNextPage();
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> submitStep(int index) async {
    switch (OnboardHalper.steps[index]) {
      case OnboardStep.name:
        return addName(name: nameController.text.trim());

      case OnboardStep.gender:
        return addGender(
          gender: selectedGender.value.toLowerCase(),
          genderPreview: genderPreview.value,
        );

      case OnboardStep.dob:
        return addDob(dob: selectedDob.value);

      case OnboardStep.height:
        return addHeight(feet: feet.value, cm: cm.value);

      case OnboardStep.dateWith:
        return addDateWith(dateWith: dateWithList);

      case OnboardStep.allOfame:
        return Get.find<OnboardPhotoController>().saveHallOfFame();
    }
  }

  Future<void> setPagesValue(PageValues pagesValue) async {
    if (pagesValue.name != null && pagesValue.name!.isNotEmpty) {
      nameController.text = pagesValue.name!;
      isNameValid.value = true;
    }

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

    if (pagesValue.dob != null && pagesValue.dob!.isNotEmpty) {
      final dateValue = AppMethods.formatFromIso(pagesValue.dob!);
      dobController.value = dateValue['ui'] ?? '';
      selectedDob.value = dateValue['api'] ?? '';
      isDobSelected.value = true;
    }

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

      isDateSelectedP.value = dateWithList.isNotEmpty;
    }

    if (pagesValue.height != null && pagesValue.height!.feet != null) {
      isHeightSelected.value = true;

      final double height = pagesValue.height!.feet!;
      final int feetValue = height.floor();
      final int inchesValue = ((height - feetValue) * 10).round();

      heightController.value = '$feetValue feet $inchesValue inch';
      feet.value = feetValue.toDouble();
      cm.value = pagesValue.height!.cm ?? 0.0;
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
    currentIndex.value = index == -1 ? 0 : index;
    return index == -1 ? 0 : index;
  }

  int get nextIncompleteIndex => stepStatus.indexWhere((e) => e == false);

  Future<void> completeStep(int index) async {
    if (index < 0 || index >= stepStatus.length) return;

    stepStatus[index] = true;
    stepStatus.refresh();
    _goToNextStepOrFinish();
  }

  void _goToNextStepOrFinish() {
    final nextIndex = nextIncompleteIndex;

    if (nextIndex == -1) {
      navigateOff(AppRoutes.currentLoadingScreen);
    } else {
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentIndex.value = nextIndex;
    }

    updateButtonState();
  }

  void goToNextPage() {
    isNextPageEnable.value = true;
  }

  void updateButtonState() {
    switch (currentIndex.value) {
      case 0:
        isButtonEnabled.value = nameController.text.trim().length >= 3;
        break;
      case 1:
        isButtonEnabled.value = selectedGender.value.isNotEmpty;
        break;
      case 2:
        isButtonEnabled.value = selectedDob.value.isNotEmpty;
        break;
      case 3:
        isButtonEnabled.value = heightController.value.isNotEmpty;
        break;
      case 4:
        isButtonEnabled.value = dateWithList.isNotEmpty;
        break;
      case 5:
        isButtonEnabled.value = true;
        break;
      default:
        isButtonEnabled.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    pageController.dispose();
    currentIndex.dispose();
    super.onClose();
  }
}
