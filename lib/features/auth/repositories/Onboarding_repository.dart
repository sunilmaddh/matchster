import 'package:matchster/core/network/api_response.dart';
import 'package:matchster/features/auth/models/add_date_with_response.dart';
import 'package:matchster/features/auth/models/add_dob_response.dart';
import 'package:matchster/features/auth/models/add_gender_response.dart';
import 'package:matchster/features/auth/models/add_hieght_response.dart';
import 'package:matchster/features/auth/models/add_name_response.dart';
import 'package:matchster/features/auth/models/reverse_geocode_response.dart';
import 'package:matchster/features/auth/models/upload_photo_response.dart';
import 'package:matchster/features/auth/services/onboarding_service.dart';

class OnboardingRepository {
  OnboardingRepository({required this.onboardingService});
  final OnboardingService onboardingService;
  Future<ApiResponse<AddNameResponse>> addName({required String name}) async {
    return onboardingService.addName(name: name);
  }

  Future<ApiResponse<AddGenderResponse>> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    return onboardingService.addGender(
      gender: gender,
      genderPreview: genderPreview,
    );
  }

  Future<ApiResponse<AddDobResponse>> addDob({required String dob}) async {
    return onboardingService.addDob(dob: dob);
  }

  Future<ApiResponse<AddHieghtResponse>> addHeight({
    required double feet,
    required double cm,
  }) async {
    return onboardingService.addHieght(feet: feet, cm: cm);
  }

  Future<ApiResponse<AddDateWithResponse>> addDateWith({
    required List<String> dateWith,
  }) async {
    return onboardingService.addDateWith(dateWith: dateWith);
  }

  Future<ApiResponse<void>> allOfFame({
    required List<String> imageListUrl,
  }) async {
    return onboardingService.allOfFame(imageUrlList: imageListUrl);
  }

  Future<ApiResponse<UploadPhotoResponse>?> uploadUserPhoto({
    required String imagePath,
  }) async {
    return await onboardingService.uploadImageWithDio(imagePath);
  }

  Future<ApiResponse<AddDateWithResponse>> addCurrentLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    return await onboardingService.addCurrentLocation(
      lat: lat,
      lng: lng,
      label: label,
      city: city,
      state: state,
      country: country,
    );
  }

  Future<ApiResponse<AddDateWithResponse>> addHomeLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    return await onboardingService.addHomeLocation(
      lat: lat,
      lng: lng,
      label: label,
      city: city,
      state: state,
      country: country,
    );
  }

  Future<ApiResponse<ReverseGeocodeResponse>> getAddress({
    required double lat,
    required double lng,
  }) async {
    return await onboardingService.getAddress(lat: lat, lng: lng);
  }
}
