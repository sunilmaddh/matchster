import 'package:matchster/core/error/app_exception.dart';
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
    final response = await onboardingService.addName(name: name);
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<AddGenderResponse>> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    final response = await onboardingService.addGender(
      gender: gender,
      genderPreview: genderPreview,
    );
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<AddDobResponse>> addDob({required String dob}) async {
    return onboardingService.addDob(dob: dob);
  }

  Future<BaseResponse<AddHieghtResponse>> addHeight({
    required double feet,
    required double cm,
  }) async {
    final response = await onboardingService.addHieght(feet: feet, cm: cm);
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<AddDateWithResponse>> addDateWith({
    required List<String> dateWith,
  }) async {
    final response = await onboardingService.addDateWith(dateWith: dateWith);
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<void>> allOfFame({
    required List<String> imageListUrl,
  }) async {
    final response = await onboardingService.allOfFame(
      imageUrlList: imageListUrl,
    );
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
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
    final response = await onboardingService.addCurrentLocation(
      lat: lat,
      lng: lng,
      label: label,
      city: city,
      state: state,
      country: country,
    );
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    final response = await onboardingService.addHomeLocation(
      lat: lat,
      lng: lng,
      label: label,
      city: city,
      state: state,
      country: country,
    );
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<ReverseGeocodeResponse>> getAddress({
    required double lat,
    required double lng,
  }) async {
    final response = await onboardingService.getAddress(lat: lat, lng: lng);
    if (!response.success) {
      throw AppException(response.message);
    }
    return response;
  }
}
