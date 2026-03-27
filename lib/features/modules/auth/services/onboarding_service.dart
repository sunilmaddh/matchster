import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/modules/auth/models/add_date_with_response.dart';
import 'package:matchster/features/modules/auth/models/add_dob_response.dart';
import 'package:matchster/features/modules/auth/models/add_gender_response.dart';
import 'package:matchster/features/modules/auth/models/add_hieght_response.dart';
import 'package:matchster/features/modules/auth/models/add_name_response.dart';
import 'package:matchster/features/modules/auth/models/reverse_geocode_response.dart';
import 'package:matchster/features/modules/auth/models/upload_photo_response.dart';

class OnboardingService {
  OnboardingService({required this.baseService});
  final BaseService baseService;
  Future<BaseResponse<AddNameResponse>> addName({required String name}) async {
    return baseService.postRequest<AddNameResponse>(
      path: ApiEndpoints.addName,
      data: {"name": name},
      fromJsonT: (json) => AddNameResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddGenderResponse>> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    return baseService.postRequest<AddGenderResponse>(
      path: ApiEndpoints.addGender,
      data: {"gender": gender, "genderPreview": genderPreview},
      fromJsonT: (json) => AddGenderResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddDobResponse>> addDob({required String dob}) async {
    return baseService.postRequest<AddDobResponse>(
      path: ApiEndpoints.addDob,
      data: {"dob": dob},
      fromJsonT: (json) => AddDobResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddHieghtResponse>> addHieght({
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

  Future<BaseResponse<AddDateWithResponse>> addDateWith({
    required List dateWith,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addDateWith,
      data: {"dateWith": dateWith},
      fromJsonT: (json) => AddDateWithResponse.fromJson(json),
    );
  }

  Future<BaseResponse<void>> allOfFame({required List imageUrlList}) async {
    return baseService.postRequest<void>(
      path: ApiEndpoints.allOfFame,
      data: {"urls": imageUrlList},
    );
  }

  Future<BaseResponse<ReverseGeocodeResponse>> getAddress({
    required double lat,
    required double lng,
  }) async {
    return baseService.postRequest<ReverseGeocodeResponse>(
      path: "${ApiEndpoints.reverseGeocoding}?lat=$lat&lng=$lng",
      fromJsonT: (json) => ReverseGeocodeResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddDateWithResponse>> addCurrentLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addCurrentLocation,
      data: {
        "currentLocation": {
          "lat": lat,
          "lng": lng,
          "address": {
            "label": label,
            "city": city,
            "state": state,
            "country": country,
          },
        },
      },
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
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addHomeTownLocation,
      data: {
        "homeTown": {
          "lat": lat,
          "lng": lng,
          "address": {
            "label": label,
            "city": city,
            "state": state,
            "country": country,
          },
        },
      },
    );
  }

  Future<BaseResponse<UploadPhotoResponse>?> uploadImageWithDio(
    String filePath,
  ) async {
    try {
      debugPrint('File path: $filePath');

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
      debugPrint('uploadImageWithDio error: ${response.message}');
      return response;
    } catch (e, stackTrace) {
      debugPrint('uploadImageWithDio error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }
}
