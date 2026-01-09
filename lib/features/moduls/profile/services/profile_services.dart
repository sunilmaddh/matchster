import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';

class ProfileServices {
  final BaseService _baseService = BaseService();

  Future<BaseResponse<void>> addWorkout({required String workout}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addWorkout,
      data: {"workout": workout},
    );
  }

  Future<BaseResponse<void>> addSmoking({required String smoking}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addSmoking,
      data: {"smoking": smoking},
    );
  }

  Future<BaseResponse<void>> addDrinking({required String drinking}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addDrinking,
      data: {"drinking": drinking},
    );
  }

  Future<BaseResponse<void>> addInterests({required List interests}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addInterests,
      data: {"interests": interests},
    );
  }

  Future<BaseResponse<void>> addLanguages({required List languages}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addLanguages,
      data: {"languages": languages},
    );
  }

  Future<BaseResponse<void>> addZodiacsign({required String zodiacsign}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addZodiacsign,
      data: {"zodiacSign": zodiacsign},
    );
  }

  Future<BaseResponse<void>> addReligion({required String religion}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addReligion,
      data: {"religion": religion},
    );
  }

  Future<BaseResponse<void>> addVisibility({required String visibility}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addVisibility,
      data: {"visibility": visibility},
    );
  }

  Future<BaseResponse<void>> addLooking({required String lookingFor}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addLookingfor,
      data: {"lookingFor": lookingFor},
    );
  }

  Future<BaseResponse<void>> addQualification({
    required String qualification,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addQualification,
      data: {"qualification": qualification},
    );
  }

  Future<BaseResponse<void>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addWork,
      data: {
        "work": {"jobTitle": jobTitle, "company": company},
      },
    );
  }

  Future<BaseResponse<void>> addAbout({required String about}) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addAbout,
      data: {"about": about},
    );
  }
}
