import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
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

  Future<BaseResponse<Map<String, dynamic>>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await _baseService.postRequest(
      path: ApiEndpoints.addWork,
      data: {
        "work": {"jobTitle": jobTitle, "company": company},
      },
      fromJsonT: (json) => json,
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
}
