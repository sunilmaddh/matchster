import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/models/auto_complete_response.dart';

class LocationController extends BaseController {
  LocationController({
    required this.profileController,
    required this.onboardController,
  });

  final ProfileController profileController;
  final OnboardController onboardController;

  final TextEditingController cityController = TextEditingController();

  final RxString selectedState = ''.obs;
  final RxString selectedCountry = 'India'.obs;
  final RxBool isSubmitEnabled = false.obs;

  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    cityController.addListener(_validateForm);
  }

  Future<void> fetchCurrentLocation() async {
    final result = await onboardController.fetchLocation();
    latitude.value = result?.latitude ?? 0.0;
    longitude.value = result?.longitude ?? 0.0;
  }

  void onCityChanged(String value) {
    _validateForm();
  }

  void onStateSelected(String value) {
    selectedState.value = value;
    _validateForm();
  }

  void _validateForm() {
    final city = cityController.text.trim();
    isSubmitEnabled.value = city.isNotEmpty && selectedState.value.isNotEmpty;
  }

  Future<void> submitHomeTown() async {
    if (!isSubmitEnabled.value) return;

    await profileController.addHomeLocation(
      city: cityController.text.trim(),
      state: selectedState.value,
      country: selectedCountry.value,
    );
  }

  Future<void> confirmCurrentLocationChange() async {
    await onboardController.addHomeLocation(
      lat: latitude.value,
      lng: longitude.value,
      label: '',
      city: cityController.text.trim(),
      state: selectedState.value,
      country: selectedCountry.value,
    );
  }

  final RxList<AutoCompleteResponse> autoCompleteResponse =
      <AutoCompleteResponse>[].obs;

  Future<void> autoCompleteLocation({required String query}) async {
    final response = await profileController.autoCompleteLocation(query: query);
    if (response != null && response != []) {
      autoCompleteResponse.assignAll(response);
    }
  }

  Future<void> placeDetailsLocation({required String placeId}) async {
    await profileController.fetchPlaceDetails(placeId: placeId);
  }

  @override
  void onClose() {
    cityController.dispose();
    super.onClose();
  }
}
