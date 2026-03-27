import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/auth/models/add_date_with_response.dart';
import 'package:matchster/features/auth/models/add_hieght_response.dart';
import 'package:matchster/features/auth/models/upload_photo_response.dart';
import 'package:matchster/features/profile/models/auto_complete_response.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/models/place_details_response.dart';
import 'package:matchster/features/profile/services/profile_services.dart';

class ProfileRepository {
  ProfileRepository({required this.profileService});
  final ProfileService profileService;

  Future<BaseResponse<MyProfilResponse>> getMyProfile() async {
    return await profileService.getMyProfile();
  }

  Future<BaseResponse<Map<String, dynamic>>> addWorkout({
    required String workout,
  }) async {
    return await profileService.addWorkout(workout: workout);
  }

  Future<BaseResponse<Map<String, dynamic>>> addSmoking({
    required String smoking,
  }) async {
    return await profileService.addSmoking(smoking: smoking);
  }

  Future<BaseResponse<Map<String, dynamic>>> addDrinking({
    required String drinking,
  }) async {
    return await addDrinking(drinking: drinking);
  }

  Future<BaseResponse<Map<String, dynamic>>> addInterests({
    required List interests,
  }) async {
    return await profileService.addInterests(interests: interests);
  }

  Future<BaseResponse<Map<String, dynamic>>> addLanguages({
    required List languages,
  }) async {
    return await profileService.addLanguages(languages: languages);
  }

  Future<BaseResponse<Map<String, dynamic>>> addZodiacsign({
    required String zodiacsign,
  }) async {
    return await addZodiacsign(zodiacsign: zodiacsign);
  }

  Future<BaseResponse<Map<String, dynamic>>> addReligion({
    required String religion,
  }) async {
    return await profileService.addReligion(religion: religion);
  }

  Future<BaseResponse<Map<String, dynamic>>> addVisibility({
    required String visibility,
  }) async {
    return await profileService.addVisibility(visibility: visibility);
  }

  Future<BaseResponse<Map<String, dynamic>>> addLooking({
    required List<String> lookingFor,
  }) async {
    return await profileService.addLooking(lookingFor: lookingFor);
  }

  Future<BaseResponse<Map<String, dynamic>>> addQualification({
    required String qualification,
  }) async {
    return await profileService.addQualification(qualification: qualification);
  }

  Future<BaseResponse<Work>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await profileService.addWork(jobTitle: jobTitle, company: company);
  }

  Future<BaseResponse<AddHieghtResponse>> addHeight({
    required double feet,
    required double cm,
  }) async {
    return await profileService.addHieght(feet: feet, cm: cm);
  }

  Future<BaseResponse<Map<String, dynamic>>> addAbout({
    required String about,
  }) async {
    return await profileService.addAbout(about: about);
  }

  Future<BaseResponse<List<AutoCompleteResponse>>> autoCompleteSearchLocation({
    required String query,
  }) async {
    return await profileService.autoCompleteSearchLocation(query: query);
  }

  Future<BaseResponse<PlaceDetailsResponse>> placeDetails({
    required String placeId,
  }) async {
    return await profileService.placeDetails(placeId: placeId);
  }

  Future<BaseResponse<void>> deleteProfile({required String profileId}) async {
    return await profileService.deleteProfile(profileId: profileId);
  }

  Future<BaseResponse<void>> addPhoto({required String url}) async {
    return await profileService.addPhoto(url: url);
  }

  Future<BaseResponse<UploadPhotoResponse>?> uploadImageWithDio(
    String filePath,
  ) async {
    return await profileService.uploadImageWithDio(filePath);
  }

  Future<BaseResponse<AddDateWithResponse>> allOfFame({
    required List imageUrlList,
  }) async {
    return profileService.allOfFame(imageUrlList: imageUrlList);
  }

  Future<BaseResponse<AddDateWithResponse>> addProfile({
    required List imageUrlList,
  }) async {
    return await profileService.addProfile(imageUrlList: imageUrlList);
  }

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
    required String city,
    required String state,
    required String country,
  }) async {
    return await profileService.addHomeLocation(
      city: city,
      state: state,
      country: country,
    );
  }
}
