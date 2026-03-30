import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';

class ProfileFormController extends GetxController {
  final RxList<String> selectedInterests = <String>[].obs;
  final RxList<String> selectedLanguages = <String>[].obs;
  final RxString selectedLookingFor = "".obs;

  final RxString selectedWorkout = ''.obs;
  final RxString selectedSmoke = ''.obs;
  final RxString selectedDrinking = ''.obs;
  final RxString selectedReligion = ''.obs;
  final RxString selectedVisibility = ''.obs;
  final RxString selectedZodiac = ''.obs;
  final RxBool isAboutEnable = false.obs;

  final RxInt selectedEducationIndex = 0.obs;
  final RxDouble feet = 0.0.obs;
  final RxDouble cm = 0.0.obs;

  final RxBool isEditEnable = false.obs;

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  void clear() {
    selectedInterests.clear();
    selectedLanguages.clear();
    selectedLookingFor.value = "";

    selectedWorkout.value = '';
    selectedSmoke.value = '';
    selectedDrinking.value = '';
    selectedReligion.value = '';
    selectedVisibility.value = '';
    selectedZodiac.value = '';
    selectedEducationIndex.value = 0;
    feet.value = 0;
    cm.value = 0;

    jobTitleController.clear();
    companyController.clear();
    cityController.clear();
    aboutController.clear();
  }

  void setInterestsFromApi(List<String>? apiList) {
    if (apiList == null || apiList.isEmpty) return;
    selectedInterests
      ..clear()
      ..addAll(apiList.toSet());
  }

  void setLanguagesFromApi(List<String>? apiList) {
    if (apiList == null || apiList.isEmpty) return;

    final formatted =
        apiList
            .map(
              (e) =>
                  e.isNotEmpty
                      ? e[0].toUpperCase() + e.substring(1).toLowerCase()
                      : e,
            )
            .toSet()
            .toList();

    selectedLanguages
      ..clear()
      ..addAll(formatted);
  }

  void setLookingFromApi(String apiList) {
    if (apiList == null || apiList.isEmpty) return;

    selectedLookingFor.value = apiList;
    // apiList.map((e) => e.toCapitalizedWords()).toSet().toList();
  }

  void loadInterestsFromApi(List<String> apiList) {
    selectedInterests.clear();
    for (final value in apiList) {
      final interest = InterestEnumX.fromString(value);
      if (interest != null) {
        selectedInterests.add(interest.label);
      }
    }
    AppMethods.appPrint(message: "SelectedInterest: $selectedInterests");
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    companyController.dispose();
    cityController.dispose();
    aboutController.dispose();
    super.onClose();
  }

  void addQualification({required ProfileFormController qualification}) {}
}
