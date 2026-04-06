import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/auth/model/response/add_date_with_response.dart';
import 'package:matchster/features/auth/model/response/add_dob_response.dart';
import 'package:matchster/features/auth/model/response/add_gender_response.dart';
import 'package:matchster/features/auth/model/response/add_hieght_response.dart';
import 'package:matchster/features/auth/model/response/add_name_response.dart';
import 'package:matchster/features/auth/model/response/reverse_geocode_response.dart';
import 'package:matchster/features/auth/model/response/upload_photo_response.dart';
import 'package:matchster/features/auth/services/onboard_service.dart';

class OnboardingRepository {
  OnboardingRepository({required this.onboardingService});
  final OnboardingService onboardingService;
  Future<BaseResponse<AddNameResponse>> addName({required String name}) async {
    return onboardingService.addName(name: name);
  }

  Future<BaseResponse<AddGenderResponse>> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    return onboardingService.addGender(
      gender: gender,
      genderPreview: genderPreview,
    );
  }

  Future<BaseResponse<AddDobResponse>> addDob({required String dob}) async {
    return onboardingService.addDob(dob: dob);
  }

  Future<BaseResponse<AddHieghtResponse>> addHeight({
    required double feet,
    required double cm,
  }) async {
    return onboardingService.addHieght(feet: feet, cm: cm);
  }

  Future<BaseResponse<AddDateWithResponse>> addDateWith({
    required List<String> dateWith,
  }) async {
    return onboardingService.addDateWith(dateWith: dateWith);
  }

  Future<BaseResponse<void>> allOfFame({
    required List<String> imageListUrl,
  }) async {
    return onboardingService.allOfFame(imageUrlList: imageListUrl);
  }

  Future<BaseResponse<UploadPhotoResponse>?> uploadUserPhoto({
    required String imagePath,
  }) async {
    return await onboardingService.uploadImageWithDio(imagePath);
  }

  Future<BaseResponse<AddDateWithResponse>> addCurrentLocation({
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

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
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

  Future<BaseResponse<ReverseGeocodeResponse>> getAddress({
    required double lat,
    required double lng,
  }) async {
    return await onboardingService.getAddress(lat: lat, lng: lng);
  }
}
