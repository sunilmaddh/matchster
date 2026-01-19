import 'dart:io';

import 'package:get/get.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/utils_methods.dart';
import 'package:matchster/features/moduls/profile/models/auto_complete_response.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/models/place_details_response.dart';
import 'package:matchster/features/moduls/profile/services/profile_services.dart';
import 'package:matchster/features/moduls/profile/view/location/add_location_screen.dart';

class ProfileController extends GetxController {
  final ProfileServices _profileServices = ProfileServices();

  RxBool isSelected = false.obs;
  RxList<String> selectedItems = <String>[].obs;
  RxList<String> selectedInterests = <String>[].obs;
  RxList<String> selectedLanguage = <String>[].obs;
  RxString selectedWorkout = ''.obs;
  RxString selectedSmoke = ''.obs;
  RxString selectedDrinking = ''.obs;
  RxString selectedReligion = ''.obs;
  RxString selectedVisibility = ''.obs;
  RxString selectedLooking = ''.obs;
  RxString selectedZodiac = ''.obs;
  RxInt selectedEduIndex = 0.obs;
  Rx<MyProfilResponse> myProfileResponse = MyProfilResponse().obs;
  Rx<BasicInfo> basicInfo = BasicInfo().obs;
  RxList<HallOfFame> allPfFame = <HallOfFame>[].obs;
  Rx<Lifestyle> lifestyle = Lifestyle().obs;
  Rx<Preferences> prefeence = Preferences().obs;
  Rx<Personal> personal = Personal().obs;
  Rx<Professional> professional = Professional().obs;
  Rx<Bio> bio = Bio().obs;
  Rx<Locations> locations = Locations().obs;
  Rx<CurrentLocation> currentLocations = CurrentLocation().obs;
  Rx<CurrentLocation> hometLocations = CurrentLocation().obs;
  Rx<Meta> meta = Meta().obs;
  RxInt selectedIndex = 1.obs;
  RxDouble lattitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString qualification = ''.obs;
  final RxList<File> images = <File>[].obs;
  RxBool isProfileLoading = false.obs;
  RxList<AutoCompleteResponse> autoCompleteResponse =
      <AutoCompleteResponse>[].obs;
  Rx<PlaceDetailsResponse> placeDetails = PlaceDetailsResponse().obs;

  Future<void> addWorkout({required String workout}) async {
    try {
      final response = await _profileServices.addWorkout(
        workout: workout.toLowerCase(),
      );

      if (response.success) {
        final workoutValue = UtilMethods.stringParser(
          response.data?['workout'],
        );

        lifestyle.value = lifestyle.value.copyWith(workout: workoutValue);

        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addDrinkking({required String drinking}) async {
    try {
      final response = await _profileServices.addDrinking(
        drinking: drinking.toLowerCase(),
      );
      if (response.success) {
        final drinking = UtilMethods.stringParser(response.data?['drinking']);

        lifestyle.value = lifestyle.value.copyWith(drinking: drinking);

        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addSmoking({required String smoking}) async {
    try {
      final response = await _profileServices.addSmoking(
        smoking: smoking.toLowerCase(),
      );
      if (response.success) {
        final smoking = UtilMethods.stringParser(response.data?['smoking']);

        lifestyle.value = lifestyle.value.copyWith(smoking: smoking);

        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addInterests({required List<String> interests}) async {
    try {
      final response = await _profileServices.addInterests(
        interests: interests,
      );
      if (response.success) {
        final interestsValue =
            (response.data?['interests'] as List?)
                ?.map((e) => e.toString())
                .toList();

        personal.value = personal.value.copyWith(interests: interestsValue);

        AppMethods.appPrint(message: response.message);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addLanguages({required List<String> languages}) async {
    try {
      final response = await _profileServices.addLanguages(
        languages: languages,
      );
      if (response.success) {
        final languages =
            (response.data?['languages'] as List?)
                ?.map((e) => e.toString())
                .toList();
        personal.value = personal.value.copyWith(languages: languages);

        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addZodiacsign({required String zodiacsign}) async {
    try {
      final response = await _profileServices.addZodiacsign(
        zodiacsign: zodiacsign,
      );
      if (response.success) {
        final zodiacSign = UtilMethods.stringParser(
          response.data?['zodiacSign'],
        );

        personal.value = personal.value.copyWith(zodiacSign: zodiacSign);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addReligion({required String religion}) async {
    try {
      final response = await _profileServices.addReligion(religion: religion);
      if (response.success) {
        final religion = UtilMethods.stringParser(response.data?['religion']);

        personal.value = personal.value.copyWith(religion: religion);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addVisibility({required String visibility}) async {
    try {
      final response = await _profileServices.addVisibility(
        visibility: visibility,
      );
      if (response.success) {
        final visibility = UtilMethods.stringParser(
          response.data?['visibility'],
        );

        prefeence.value = prefeence.value.copyWith(visibility: visibility);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addLookingFor({required String lookingFor}) async {
    try {
      final response = await _profileServices.addLooking(
        lookingFor: lookingFor,
      );
      if (response.success) {
        final lookingFor = UtilMethods.stringParser(
          response.data?['lookingFor'],
        );

        prefeence.value = prefeence.value.copyWith(lookingFor: lookingFor);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addQualification({required String qualification}) async {
    try {
      final response = await _profileServices.addQualification(
        qualification: qualification,
      );
      if (response.success) {
        final qualification = UtilMethods.stringParser(
          response.data?['qualification'],
        );

        personal.value = personal.value.copyWith(qualification: qualification);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addWork({
    required String jobTitle,
    required String company,
  }) async {
    try {
      final response = await _profileServices.addWork(
        jobTitle: jobTitle,
        company: company,
      );
      if (response.success) {
        AppMethods.appPrint(message: response.message);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addAout({required String about}) async {
    try {
      final response = await _profileServices.addAbout(about: about);
      if (response.success) {
        AppMethods.appPrint(message: response.message);
        Get.back();
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> autoCompleteLocation({required String query}) async {
    try {
      final response = await _profileServices.autoCompleteSearchLocation(
        query: query,
      );
      if (response.success) {
        AppMethods.appPrint(message: "AutoComplete response ${response.data}");
        if (response.data != null) {
          autoCompleteResponse.value = response.data!;
          AppMethods.appPrint(
            message: "AutoComplete response ${response.data}",
          );
        } else {
          autoCompleteResponse.clear();
        }
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> placeDetailsLocation({required String placeId}) async {
    try {
      final response = await _profileServices.placeDetails(placeId: placeId);
      if (response.success) {
        placeDetails.value = response.data!;
        Get.to(AddLocationScreen());
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> getMyProfile() async {
    try {
      isProfileLoading(true);
      final response = await _profileServices.getMyProfile();
      if (response.success) {
        final data = response.data;
        if (data != null) {
          basicInfo.value = data.basicInfo!;
          allPfFame.value = data.hallOfFame!;
          lifestyle.value = data.lifestyle!;
          prefeence.value = data.preferences!;
          personal.value = data.personal!;
          professional.value = data.professional!;
          locations.value = data.locations!;
          bio.value = data.bio!;
          meta.value = data.meta!;
          currentLocations.value = data.locations!.currentLocation!;
          hometLocations.value = data.locations!.homeTown!;
        }
        await Future.delayed(Duration(seconds: 5), () {
          isProfileLoading(false);
        });
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
          isError: true,
        );
        isProfileLoading(false);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      isProfileLoading(false);
    }
  }
}
