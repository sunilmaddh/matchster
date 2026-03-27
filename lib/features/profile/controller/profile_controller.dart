import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/photo_review_bottomsheet.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/models/habit_option.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/profile/models/auto_complete_response.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/models/place_details_response.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/features/profile/view/location/add_location_screen.dart';
import 'package:matchster/features/profile/view/profile/profile_photo_preview_screen.dart';

class ProfileController extends GetxController {
  ProfileController({required this.profileRepository});
  final ProfileRepository profileRepository;
  RxBool isSelected = false.obs;
  RxList<String> selectedItems = <String>[].obs;
  RxList<String> selectedInterests = <String>[].obs;
  RxList<String> selectedLanguage = <String>[].obs;
  RxList<String> selectedLookingFor = <String>[].obs;
  RxString selectedWorkout = ''.obs;
  RxString selectedSmoke = ''.obs;
  RxString selectedDrinking = ''.obs;
  RxString selectedReligion = ''.obs;
  RxString selectedVisibility = ''.obs;
  RxString selectedLooking = ''.obs;
  RxString selectedZodiac = ''.obs;
  RxInt selectedEduIndex = 10.obs;
  RxBool isImageUploading = false.obs;
  Rx<MyProfilResponse> myProfileResponse = MyProfilResponse().obs;
  Rx<BasicInfo> basicInfo = BasicInfo().obs;
  RxList<HallOfFame> allPfFames = <HallOfFame>[].obs;
  Rx<Lifestyle> lifestyle = Lifestyle().obs;
  Rx<Preferences> prefeence = Preferences().obs;
  Rx<Personal> personal = Personal().obs;
  Rx<Work> work = Work().obs;
  Rx<Professional> professional = Professional().obs;
  Rx<Bio> bio = Bio().obs;
  Rx<Locations> locations = Locations().obs;
  Rx<CurrentLocation> currentLocations = CurrentLocation().obs;
  Rx<HomeTown> hometLocations = HomeTown().obs;
  Rx<Meta> meta = Meta().obs;
  RxInt selectedIndex = 1.obs;
  RxDouble lattitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString qualification = ''.obs;
  final RxList<File> images = <File>[].obs;
  RxBool isProfileLoading = false.obs;
  RxString selectedState = "".obs;
  RxBool isEnable = false.obs;
  RxList<AutoCompleteResponse> autoCompleteResponse =
      <AutoCompleteResponse>[].obs;
  Rx<PlaceDetailsResponse> placeDetails = PlaceDetailsResponse().obs;
  late final FaceDetector faceDetector;
  RxBool isAboutEnable = false.obs;
  RxDouble feet = 0.0.obs;
  RxDouble cm = 0.0.obs;
  RxBool isEditEnable = false.obs;
  RxString heightController = "".obs;
  final TextEditingController jobTtileController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  void clearData() {
    jobTtileController.clear();
    cityController.clear();
    companyController.clear();
    aboutController.clear();
    isAboutEnable.value = false;
    selectedDrinking.value = "";
    selectedSmoke.value = "";
    selectedInterests.clear();
    selectedItems.clear();
    selectedLanguage.clear();
    selectedLooking.value = "";
    selectedLookingFor.clear();
    selectedReligion.value = "";
    selectedVisibility.value = "";
    selectedZodiac.value = "";
    selectedEduIndex.value = 0;
    qualification.value = "";
    feet.value = 0;
    cm.value = 0;
    heightController.value = "";
  }

  @override
  void onInit() {
    super.onInit();
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableClassification: true,
        enableTracking: false,
        minFaceSize: 0.15,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  Future<void> addWorkout({required String workout}) async {
    try {
      final response = await profileRepository.addWorkout(
        workout: workout.toLowerCase(),
      );

      if (response.success) {
        // final workoutValue = UtilMethods.stringParser(
        //   response.data?['workout'],
        // );

        // lifestyle.value = lifestyle.value.copyWith(workout: workoutValue);
        await getMyProfile(false);
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
      final response = await profileRepository.addDrinking(
        drinking: drinking.toLowerCase(),
      );
      if (response.success) {
        // final drinking = UtilMethods.stringParser(response.data?['drinking']);

        // lifestyle.value = lifestyle.value.copyWith(drinking: drinking);
        await getMyProfile(false);
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
      final response = await profileRepository.addSmoking(
        smoking: smoking.toLowerCase(),
      );
      if (response.success) {
        // final smoking = UtilMethods.stringParser(response.data?['smoking']);

        // lifestyle.value = lifestyle.value.copyWith(smoking: smoking);
        await getMyProfile(false);
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

  Future<void> addHeight() async {
    try {
      final response = await profileRepository.addHeight(
        feet: feet.value,
        cm: cm.value,
      );
      if (response.success) {
        await getMyProfile(false);
        Get.back();
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
      final response = await profileRepository.addInterests(
        interests: interests,
      );
      if (response.success) {
        // final interestsValue =
        //     (response.data?['interests'] as List?)
        //         ?.map((e) => e.toString())
        //         .toList();

        // personal.value = personal.value.copyWith(interests: interestsValue);
        await getMyProfile(false);

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
      final response = await profileRepository.addLanguages(
        languages: languages,
      );
      if (response.success) {
        await getMyProfile(false);
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
      final response = await profileRepository.addZodiacsign(
        zodiacsign: zodiacsign,
      );
      if (response.success) {
        await getMyProfile(false);
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
      final response = await profileRepository.addReligion(
        religion: religion.toSnakeCaseLowerCase(),
      );
      if (response.success) {
        await getMyProfile(false);
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
      final response = await profileRepository.addVisibility(
        visibility: visibility,
      );
      if (response.success) {
        await getMyProfile(false);
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

  Future<void> addLookingFor({required List<String> lookingFor}) async {
    try {
      final response = await profileRepository.addLooking(
        lookingFor: lookingFor,
      );
      if (response.success) {
        await getMyProfile(false);
        selectedLookingFor.clear();
        Get.back();
      } else {
        selectedLookingFor.clear();
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
      final response = await profileRepository.addQualification(
        qualification: qualification,
      );
      if (response.success) {
        await getMyProfile(false);
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

  Future<bool> uploadPhotoW({required String imagePath}) async {
    try {
      final response = await profileRepository.uploadImageWithDio(imagePath);
      if (response!.success) {
        final image = response.data!.url ?? '';
        bool isSuccess = await addPhoto(url: image);
        await getMyProfile(false);
        return isSuccess;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deleteProfile({required String profileId}) async {
    try {
      final response = await profileRepository.deleteProfile(
        profileId: profileId,
      );
      if (response.success) {
        await getMyProfile(false);
        Get.back();
        return true;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addPhoto({required String url}) async {
    try {
      final response = await profileRepository.addPhoto(url: url);
      if (response.success) {
        return true;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> addWork({
    required String jobTitle,
    required String company,
  }) async {
    try {
      final response = await profileRepository.addWork(
        jobTitle: jobTitle,
        company: company,
      );
      if (response.success) {
        await getMyProfile(false);
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
      final response = await profileRepository.addAbout(about: about);
      if (response.success) {
        await getMyProfile(false);
        isAboutEnable.value = false;
      } else {
        isAboutEnable.value = false;
      }
    } catch (e) {
      isAboutEnable.value = false;
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> autoCompleteLocation({required String query}) async {
    try {
      final response = await profileRepository.autoCompleteSearchLocation(
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
      final response = await profileRepository.placeDetails(placeId: placeId);
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

  Future<void> getMyProfile(bool isMain) async {
    try {
      if (isMain) {
        isProfileLoading(true);
      }

      final response = await profileRepository.getMyProfile();
      if (response.success) {
        final data = response.data;
        if (data != null) {
          basicInfo.value = data.basicInfo!;
          allPfFames.value = data.hallOfFame!;
          lifestyle.value = data.lifestyle!;
          prefeence.value = data.preferences!;
          personal.value = data.personal!;
          professional.value = data.professional!;
          locations.value = data.locations!;
          bio.value = data.bio!;
          meta.value = data.meta!;
          currentLocations.value = data.locations!.currentLocation!;
          hometLocations.value = data.locations!.homeTown!;
          aboutController.text = data.bio!.about!;
        }
        _updateInShort();
        isProfileLoading(false);
        // await Future.delayed(Duration(seconds: 5), () {

        // });
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

  Future<bool> isFaceClear(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faces = await faceDetector.processImage(inputImage);

    // ❌ No face or multiple faces
    if (faces.length != 1) return false;

    final face = faces.first;

    // ❌ Eyes closed
    if ((face.leftEyeOpenProbability ?? 0) < 0.5 ||
        (face.rightEyeOpenProbability ?? 0) < 0.5) {
      return false;
    }

    // ❌ Face turned too much
    if ((face.headEulerAngleY ?? 0).abs() > 15 ||
        (face.headEulerAngleZ ?? 0).abs() > 15) {
      return false;
    }

    return true; // ✅ Clear face
  }

  Future<void> validateAndUploadPhoto({required File file}) async {
    try {
      final isValid = await isFaceClear(file);
      if (!isValid) {
        isImageUploading(false);

        if (Get.isOverlaysOpen || Get.key.currentState?.canPop() == true) {
          Get.back();
        }
        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back();
            Get.to(() => ProfilePhotoPreviewScreen(imageFile: selectedImage));
          },
        );
        return;
      }
      final success = await uploadPhotoW(imagePath: file.path);
      isImageUploading(false);
      if (success) {
        Get.back();
      }
    } catch (e) {
      isImageUploading(false);
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<bool> allOfFameUpload({required List<String> imageUrlList}) async {
    try {
      // isPageLoading(true);
      // final cleanedList = imageUrlList.where((e) => e.isNotEmpty).toList();
      print("all $imageUrlList");
      final response = await profileRepository.allOfFame(
        imageUrlList: imageUrlList,
      );
      if (response.success) {
        return true;
      } else {
        // isPageLoading(false);
        // AppToastMessage.show(
        //   isError: true,
        //   title: "Error",
        //   message: "Success ${response.message}",
        // );
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  Future<void> addHomeLocation({
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      final response = await profileRepository.addHomeLocation(
        city: city,
        state: state,
        country: country,
      );
      if (response.success) {
        await getMyProfile(false);
        Get.back();
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  RxList<InshortList> inshortList = <InshortList>[].obs;
  Future<void> _updateInShort() async {
    // if (profile == null) {
    //   inShortList.clear();
    //   inshortList.clear();
    //   return;
    // }
    inshortList.clear();
    if (basicInfo.value.gender != null && basicInfo.value.gender!.isNotEmpty) {
      final vlaue = GenderEnumX.fromApi(basicInfo.value.gender!);
      if (vlaue != null) {
        inshortList.add(
          InshortList(
            text: basicInfo.value.gender.toString(),
            img: vlaue.emoji,
          ),
        );
      }
    }
    if (lifestyle.value.smoking!.isNotEmpty) {
      final freq = frequencyFromApi(lifestyle.value.smoking!);
      if (freq != null) {
        final smokeOption = HabitOption(
          type: HabitTypeEnum.smoke,
          frequency: freq,
        );
        inshortList.add(
          InshortList(text: smokeOption.label, img: smokeOption.emoji),
        );
      }
    }
    if (lifestyle.value.drinking != null &&
        lifestyle.value.drinking!.isNotEmpty) {
      final freq = frequencyFromApi(lifestyle.value.drinking!);
      if (freq != null) {
        final drinkOption = HabitOption(
          type: HabitTypeEnum.drinking,
          frequency: freq,
        );
        inshortList.add(
          InshortList(text: drinkOption.label, img: drinkOption.emoji),
        );
      }
    }

    if (personal.value.religion != null &&
        personal.value.religion!.isNotEmpty) {
      final value = ReligionEnumX.fromApi(personal.value.religion!);

      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if (personal.value.zodiacSign != null &&
        personal.value.zodiacSign!.isNotEmpty) {
      final value = ZodiacEnumX.fromApi(personal.value.zodiacSign!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }
    if (basicInfo.value.height != null && basicInfo.value.height!.isNotEmpty) {
      final value = HeightEnumExt.fromApi(basicInfo.value.height!);
      if (value != null) {
        inshortList.add(
          InshortList(
            text: basicInfo.value.height.toString(),
            img: value.emoji,
          ),
        );
      }
    }

    // inshortList
    //   ..clear()
    //   ..addAll(
    //     [

    //          basicInfo.value.gender,
    //          lifestyle.value.smoking,
    //          lifestyle.value.drinking,
    //          personal.value.religion,
    //          personal.value.zodiacSign,
    //          basicInfo.value.height
    //         ]
    //         .where((e) => e != null && e.toString().trim().isNotEmpty)
    //         .cast<String>(),
    //   );
  }

  Future<void> setInterestsFromApi(List<String>? apiList) async {
    if (apiList != null && apiList.isNotEmpty) {
      selectedInterests
        ..clear()
        ..addAll(apiList);
      selectedInterests.value = selectedInterests.toSet().toList();
    }
    print("SelectedInterest ${selectedInterests.toString()}");
  }

  Future<void> setLanguageFromApi(List<String>? apiList) async {
    if (apiList == null || apiList.isEmpty) return;

    final formattedList =
        apiList
            .map(
              (e) =>
                  e.isNotEmpty
                      ? e[0].toUpperCase() + e.substring(1).toLowerCase()
                      : e,
            )
            .toSet() // remove duplicates
            .toList();

    selectedLanguage
      ..clear()
      ..addAll(formattedList);

    print("SelectedLanguage: $selectedLanguage");
  }

  Future<void> setLookingFromApi(List<String>? apiList) async {
    if (apiList == null || apiList.isEmpty) return;

    selectedLookingFor.value =
        apiList
            .map((e) => e.toCapitalizedWords())
            .toSet() // remove duplicates
            .toList();

    print("SelectedLookingFor: $selectedLookingFor");
  }

  void loadFromApi(List<String> apiList) {
    selectedInterests.clear();
    for (var value in apiList) {
      final interest = InterestEnumX.fromString(value);
      if (interest != null) {
        selectedInterests.add(interest.label);
      }
    }
  }
}
