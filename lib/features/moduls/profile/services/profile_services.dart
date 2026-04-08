import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:flutter/material.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/moduls/auth/onboard/models/add_date_with_response.dart';
import 'package:matchster/features/moduls/auth/onboard/models/add_hieght_response.dart';
import 'package:matchster/features/moduls/auth/onboard/models/upload_photo_response.dart';
import 'package:matchster/features/moduls/profile/models/auto_complete_response.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/models/place_details_response.dart';

class ProfileServices {
  final BaseService _baseService = BaseService();

  Future<BaseResponse<Map<String, dynamic>>> addWorkout({
    required String workout,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addWorkout,
      data: {"workout": workout},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addSmoking({
    required String smoking,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addSmoking,
      data: {"smoking": smoking},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addDrinking({
    required String drinking,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addDrinking,
      data: {"drinking": drinking},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addInterests({
    required List interests,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addInterests,
      data: {"interests": interests},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addLanguages({
    required List languages,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addLanguages,
      data: {"languages": languages},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addZodiacsign({
    required String zodiacsign,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addZodiacsign,
      data: {"zodiacSign": zodiacsign},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addReligion({
    required String religion,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addReligion,
      data: {"religion": religion},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addVisibility({
    required String visibility,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addVisibility,
      data: {"visibility": visibility},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addLooking({
    required String lookingFor,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addLookingfor,
      data: {"lookingFor": lookingFor},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addQualification({
    required String qualification,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addQualification,
      data: {"qualification": qualification},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<Work>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await _baseService.postRequest<Work>(
      path: ApiEndpoints.addWork,
      data: {
        "work": {"jobTitle": jobTitle, "company": company},
      },
      fromJsonT: (json) => Work.fromJson(json),
    );
  }

  Future<BaseResponse<AddHieghtResponse>> addHieght({
    required double feet,
    required double cm,
  }) async {
    return _baseService.postRequest<AddHieghtResponse>(
      path: ApiEndpoints.addHieght,
      data: {
        "height": {"feet": feet, "cm": cm},
      },
      fromJsonT: (json) => AddHieghtResponse.fromJson(json),
    );
  }

  Future<BaseResponse<Map<String, dynamic>>> addAbout({
    required String about,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addAbout,
      data: {"about": about},
      fromJsonT: (json) => json,
    );
  }

  Future<BaseResponse<List<AutoCompleteResponse>>> autoCompleteSearchLocation({
    required String query,
  }) async {
    return await _baseService.postRequest<List<AutoCompleteResponse>>(
      path: "${ApiEndpoints.autoComplete}?input=$query",
      fromJsonT:
          (json) =>
              (json as List)
                  .map((e) => AutoCompleteResponse.fromJson(e))
                  .toList(),
    );
  }

  Future<BaseResponse<PlaceDetailsResponse>> placeDetails({
    required String placeId,
  }) async {
    return await _baseService.postRequest<PlaceDetailsResponse>(
      path: "${ApiEndpoints.placeDetails}?placeId=$placeId",
      fromJsonT: (json) => PlaceDetailsResponse.fromJson(json),
    );
  }

  Future<BaseResponse<MyProfilResponse>> getMyProfile() async {
    return await _baseService.getRequest<MyProfilResponse>(
      path: ApiEndpoints.myProfile,
      fromJsonT: (json) => MyProfilResponse.fromJson(json),
    );
  }

  Future<BaseResponse<void>> deleteProfile({required String profileId}) async {
    return await _baseService.deleteRequest(
      path: "${ApiEndpoints.deleteProfile}/$profileId",
    );
  }

  Future<BaseResponse<void>> addPhoto({required String url}) async {
    return await _baseService.postRequest<void>(
      path: ApiEndpoints.addProfilePicture,
      data: {'url': url},
      fromJsonT: (json) => null,
    );
  }

  Future<BaseResponse<void>> uploadProfileimage({required String url}) async {
    return await _baseService.patchRequest<void>(
      path: ApiEndpoints.uploadProfileimage,
      data: {'url': url},
      fromJsonT: (json) => null,
    );
  }

  Future<BaseResponse<UploadPhotoResponse>?> uploadImageWithDio(
    String filePath,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await _baseService.postRequest<UploadPhotoResponse>(
        path: ApiEndpoints.uploadPhoto,
        data: formData,
        fromJsonT: (json) => UploadPhotoResponse.fromJson(json),
      );

      return response;
    } catch (e, stackTrace) {
      debugPrint('uploadImageWithDio error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<BaseResponse<AddDateWithResponse>> allOfFame({
    required List imageUrlList,
  }) async {
    return _baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.allOfFame,
      data: {"urls": imageUrlList},
    );
  }

  Future<BaseResponse<AddDateWithResponse>> addProfile({
    required List imageUrlList,
  }) async {
    return _baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.allOfFame,
      data: {"urls": imageUrlList},
    );
  }

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
    required String city,
    required String state,
    required String country,
  }) async {
    return _baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addHomeTownLocation,
      data: {
        "homeTown": {"city": city, "state": state, "country": country},
      },
    );
  }

  Future<BaseResponse<List<Map<String, String>>>> getCountries({String? search}) async {
    return await _baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscCountry}${search != null ? '?search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map(
                    (e) => {
                      'name': (e['name'] ?? '').toString(),
                      'isoCode': (e['isoCode'] ?? '').toString(),
                    },
                  )
                  .toList(),
    );
  }

  /// Returns list of maps with 'name' and 'isoCode'
  Future<BaseResponse<List<Map<String, String>>>> getStates({
    required String country,
    String? search,
  }) async {
    return await _baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscState}?country=$country${search != null ? '&search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map(
                    (e) => {
                      'name': (e['name'] ?? '').toString(),
                      'isoCode': (e['isoCode'] ?? '').toString(),
                    },
                  )
                  .toList(),
    );
  }

  /// Returns list of maps with 'name'
  Future<BaseResponse<List<Map<String, String>>>> getCities({
    required String country,
    required String state,
    String? search,
  }) async {
    return await _baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscCity}?country=$country&state=$state${search != null ? '&search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map(
                    (e) => {
                      'name': (e['name'] ?? '').toString(),
                    },
                  )
                  .toList(),
    );
  }

  Future<BaseResponse<void>> swapFames({
    required int position1,
    required int position2,
  }) async {
    return await _baseService.postRequest<void>(
      path: ApiEndpoints.swapFames,
      data: {"position1": position1, "position2": position2},
      fromJsonT: (json) => null,
    );
  }

  Future<BaseResponse<void>> sendEmailOtp({required String email}) async {
    return _baseService.postRequest(
      path: ApiEndpoints.sendEmailOtp,
      data: {"email": email},
    );
  }

  Future<BaseResponse<void>> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.verifyEmailOtp,
      data: {"email": email, "otp": otp},
    );
  }
}
