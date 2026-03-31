import 'package:flutter/cupertino.dart';
import 'package:matchster/core/network/api_response.dart';
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

  Future<ApiResponse<MyProfilResponse>> getMyProfile() async {
    return await profileService.getMyProfile();
  }

  Future<ApiResponse<Map<String, dynamic>>> addWorkout({
    required String workout,
  }) async {
    return await profileService.addWorkout(workout: workout);
  }

  Future<ApiResponse<Map<String, dynamic>>> addSmoking({
    required String smoking,
  }) async {
    return await profileService.addSmoking(smoking: smoking);
  }

  Future<ApiResponse<Map<String, dynamic>>> addDrinking({
    required String drinking,
  }) async {
    return await profileService.addDrinking(drinking: drinking);
  }

  Future<ApiResponse<Map<String, dynamic>>> addInterests({
    required List interests,
  }) async {
    return await profileService.addInterests(interests: interests);
  }

  Future<ApiResponse<Map<String, dynamic>>> addLanguages({
    required List languages,
  }) async {
    return await profileService.addLanguages(languages: languages);
  }

  Future<ApiResponse<Map<String, dynamic>>> addZodiacsign({
    required String zodiacsign,
  }) async {
    return await addZodiacsign(zodiacsign: zodiacsign);
  }

  Future<ApiResponse<Map<String, dynamic>>> addReligion({
    required String religion,
  }) async {
    return await profileService.addReligion(religion: religion);
  }

  Future<ApiResponse<Map<String, dynamic>>> addVisibility({
    required String visibility,
  }) async {
    return await profileService.addVisibility(visibility: visibility);
  }

  Future<ApiResponse<Map<String, dynamic>>> addLooking({
    required String lookingFor,
  }) async {
    return await profileService.addLooking(lookingFor: lookingFor);
  }

  Future<ApiResponse<Map<String, dynamic>>> addQualification({
    required String qualification,
  }) async {
    return await profileService.addQualification(qualification: qualification);
  }

  Future<ApiResponse<Work>> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return await profileService.addWork(jobTitle: jobTitle, company: company);
  }

  Future<ApiResponse<AddHieghtResponse>> addHeight({
    required double feet,
    required double cm,
  }) async {
    return await profileService.addHieght(feet: feet, cm: cm);
  }

  Future<ApiResponse<Map<String, dynamic>>> addAbout({
    required String about,
  }) async {
    return await profileService.addAbout(about: about);
  }

  Future<ApiResponse<List<AutoCompleteResponse>>> autoCompleteSearchLocation({
    required String query,
  }) async {
    return await profileService.autoCompleteSearchLocation(query: query);
  }

  Future<ApiResponse<PlaceDetailsResponse>> placeDetails({
    required String placeId,
  }) async {
    return await profileService.placeDetails(placeId: placeId);
  }

  Future<ApiResponse<void>> deleteProfile({required String profileId}) async {
    return await profileService.deleteProfile(profileId: profileId);
  }

  Future<ApiResponse<void>> addPhoto({required String url}) async {
    return await profileService.addPhoto(url: url);
  }

  Future<ApiResponse<UploadPhotoResponse>?> uploadImageWithDio(
    String filePath,
  ) async {
    return await profileService.uploadImageWithDio(filePath);
  }

  Future<ApiResponse<AddDateWithResponse>> allOfFame({
    required List imageUrlList,
  }) async {
    return profileService.allOfFame(imageUrlList: imageUrlList);
  }

  Future<ApiResponse<AddDateWithResponse>> addProfile({
    required List imageUrlList,
  }) async {
    return await profileService.addProfile(imageUrlList: imageUrlList);
  }

  Future<ApiResponse<AddDateWithResponse>> addHomeLocation({
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

  Future<ApiResponse<void>> swapFames({
    required int position1,
    required int position2,
  }) async {
    return await profileService.swapFames(
      position1: position1,
      position2: position2,
    );
  }
}
