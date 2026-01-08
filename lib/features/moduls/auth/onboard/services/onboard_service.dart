import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/moduls/auth/login/models/add_date_with_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_dob_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_gender_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_hieght_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_name_response.dart';
import 'package:matchster/features/moduls/auth/login/models/upload_photo_response.dart';

class OnboardService {
  final BaseService _baseService = BaseService();
  Future<BaseResponse<AddNameResponse>> addName({required String name}) async {
    return _baseService.postRequest<AddNameResponse>(
      path: ApiEndpoints.addName,
      data: {"name": name},
      fromJsonT: (json) => AddNameResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddGenderResponse>> addGender({
    required String gender,
    required bool genderPreview,
  }) async {
    return _baseService.postRequest<AddGenderResponse>(
      path: ApiEndpoints.addGender,
      data: {"gender": gender, "genderPreview": genderPreview},
      fromJsonT: (json) => AddGenderResponse.fromJson(json),
    );
  }

  Future<BaseResponse<AddDobResponse>> addDob({required String dob}) async {
    return _baseService.postRequest<AddDobResponse>(
      path: ApiEndpoints.addDob,
      data: {"dob": dob},
      fromJsonT: (json) => AddDobResponse.fromJson(json),
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

  Future<BaseResponse<AddDateWithResponse>> addDateWith({
    required List dateWith,
  }) async {
    return _baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addDateWith,
      data: {"dateWith": dateWith},
      fromJsonT: (json) => AddDateWithResponse.fromJson(json),
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

      final response = await _baseService.postRequest<UploadPhotoResponse>(
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
