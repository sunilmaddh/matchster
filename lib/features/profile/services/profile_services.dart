import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:flutter/material.dart';
import 'package:matchster/core/network/api_response.dart';
import 'package:matchster/core/network/api_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/auth/models/add_date_with_response.dart';
import 'package:matchster/features/auth/models/add_hieght_response.dart';
import 'package:matchster/features/auth/models/upload_photo_response.dart';
import 'package:matchster/features/profile/models/auto_complete_response.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/models/place_details_response.dart';

class ProfileService {
  ProfileService({required this.baseService});
  final ApiService baseService;

  Future<ApiResponse<Map<String, dynamic>>> addWorkout({
    required String workout,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addWorkout,
      data: {"workout": workout},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addSmoking({
    required String smoking,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addSmoking,
      data: {"smoking": smoking},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addDrinking({
    required String drinking,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addDrinking,
      data: {"drinking": drinking},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addInterests({
    required List interests,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addInterests,
      data: {"interests": interests},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addLanguages({
    required List languages,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addLanguages,
      data: {"languages": languages},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addZodiacsign({
    required String zodiacsign,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addZodiacsign,
      data: {"zodiacSign": zodiacsign},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addReligion({
    required String religion,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addReligion,
      data: {"religion": religion},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addVisibility({
    required String visibility,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addVisibility,
      data: {"visibility": visibility},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addLooking({
    required List<String> lookingFor,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addLookingfor,
      data: {"lookingFor": lookingFor},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addQualification({
    required String qualification,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addQualification,
      data: {"qualification": qualification},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<Work>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await baseService.postRequest<Work>(
      path: ApiEndpoints.addWork,
      data: {
        "work": {"jobTitle": jobTitle, "company": company},
      },
      fromJsonT: (json) => Work.fromJson(json),
    );
  }

  Future<ApiResponse<AddHieghtResponse>> addHieght({
    required double feet,
    required double cm,
  }) async {
    return baseService.postRequest<AddHieghtResponse>(
      path: ApiEndpoints.addHieght,
      data: {
        "height": {"feet": feet, "cm": cm},
      },
      fromJsonT: (json) => AddHieghtResponse.fromJson(json),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addAbout({
    required String about,
  }) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addAbout,
      data: {"about": about},
      fromJsonT: (json) => json,
    );
  }

  Future<ApiResponse<List<AutoCompleteResponse>>> autoCompleteSearchLocation({
    required String query,
  }) async {
    return await baseService.postRequest<List<AutoCompleteResponse>>(
      path: "${ApiEndpoints.autoComplete}?input=$query",
      fromJsonT:
          (json) =>
              (json as List)
                  .map((e) => AutoCompleteResponse.fromJson(e))
                  .toList(),
    );
  }

  Future<ApiResponse<PlaceDetailsResponse>> placeDetails({
    required String placeId,
  }) async {
    return await baseService.postRequest<PlaceDetailsResponse>(
      path: "${ApiEndpoints.placeDetails}?placeId=$placeId",
      fromJsonT: (json) => PlaceDetailsResponse.fromJson(json),
    );
  }

  Future<ApiResponse<MyProfilResponse>> getMyProfile() async {
    return await baseService.getRequest<MyProfilResponse>(
      path: ApiEndpoints.myProfile,
      fromJsonT: (json) => MyProfilResponse.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteProfile({required String profileId}) async {
    return await baseService.deleteRequest(
      path: "${ApiEndpoints.deleteProfile}/$profileId",
    );
  }

  Future<ApiResponse<void>> addPhoto({required String url}) async {
    return await baseService.postRequest(
      path: ApiEndpoints.addProfilePicture,
      data: {'url': url},
    );
  }

  Future<ApiResponse<UploadPhotoResponse>?> uploadImageWithDio(
    String filePath,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await baseService.postRequest<UploadPhotoResponse>(
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

  Future<ApiResponse<AddDateWithResponse>> allOfFame({
    required List imageUrlList,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.allOfFame,
      data: {"urls": imageUrlList},
    );
  }

  Future<ApiResponse<AddDateWithResponse>> addProfile({
    required List imageUrlList,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.allOfFame,
      data: {"urls": imageUrlList},
    );
  }

  Future<ApiResponse<AddDateWithResponse>> addHomeLocation({
    required String city,
    required String state,
    required String country,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addHomeTownLocation,
      data: {
        "homeTown": {"city": city, "state": state, "country": country},
      },
    );
  }
}
