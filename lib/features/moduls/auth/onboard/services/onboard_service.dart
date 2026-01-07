import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/moduls/auth/login/models/add_date_with_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_dob_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_gender_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_hieght_response.dart';
import 'package:matchster/features/moduls/auth/login/models/add_name_response.dart';

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
    required String genderPreview,
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
      data: {"feet": feet, "cm": cm},
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
}
