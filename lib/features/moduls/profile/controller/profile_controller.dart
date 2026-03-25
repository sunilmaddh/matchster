// ignore_for_file: avoid_print

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
import 'package:matchster/core/utils/utils_methods.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/photo_review_bottomsheet.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/home/models/habit_option.dart';
import 'package:matchster/features/moduls/home/models/inshort_list.dart';
import 'package:matchster/features/moduls/profile/models/auto_complete_response.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/models/place_details_response.dart';
import 'package:matchster/features/moduls/profile/services/profile_services.dart';
import 'package:matchster/features/moduls/profile/view/location/add_location_screen.dart';
import 'package:matchster/features/moduls/profile/view/profile_photo_preview_screen.dart';

class ProfileController extends GetxController {
  final ProfileServices _profileServices = ProfileServices();
  ProfileServices get profileServices => _profileServices;

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
  Rx<BasicInfo> profileImageData = BasicInfo().obs;
  RxList<HallOfFame> allPfFame = <HallOfFame>[].obs;
  Rx<Lifestyle> lifestyle = Lifestyle().obs;
  Rx<Preferences> prefeence = Preferences().obs;
  Rx<Personal> personal = Personal().obs;
  Rx<Work> work = Work().obs;
  Rx<Professional> professional = Professional().obs;
  RxString otpValue = "".obs;
  RxBool isEnable = false.obs;
  RxBool isOtpEnable = false.obs;

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
  RxString selectedCountry = "".obs;
  RxList<String> countryList = <String>[].obs;
  RxList<String> stateList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;
  RxBool isLoadingCountries = false.obs;
  RxBool isLoadingStates = false.obs;
  RxBool isLoadingCities = false.obs;
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
  RxBool isResend = false.obs;
  RxBool isLoading = false.obs;
  RxInt otpRebuildKey = 0.obs;

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
      final response = await _profileServices.addWorkout(
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
      final response = await _profileServices.addDrinking(
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
      final response = await _profileServices.addSmoking(
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
      final response = await _profileServices.addHieght(
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
      final response = await _profileServices.addInterests(
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
      final response = await _profileServices.addLanguages(
        languages: languages,
      );
      if (response.success) {
        // final languages =
        //     (response.data?['languages'] as List?)
        //         ?.map((e) => e.toString())
        //         .toList();
        // personal.value = personal.value.copyWith(languages: languages);
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
      final response = await _profileServices.addZodiacsign(
        zodiacsign: zodiacsign,
      );
      if (response.success) {
        // final zodiac = UtilMethods.stringParser(response.data?['zodiacSign']);

        // personal.value = personal.value.copyWith(zodiacSign: zodiac);
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
      final response = await _profileServices.addReligion(
        religion: religion.toSnakeCaseLowerCase(),
      );
      if (response.success) {
        // final religion = UtilMethods.stringParser(response.data?['religion']);

        // personal.value = personal.value.copyWith(religion: religion);
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
      final response = await _profileServices.addVisibility(
        visibility: visibility,
      );
      if (response.success) {
        // final visibility = UtilMethods.stringParser(
        //   response.data?['visibility'],
        // );

        // prefeence.value = prefeence.value.copyWith(visibility: visibility);
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
      final response = await _profileServices.addLooking(
        lookingFor: lookingFor,
      );
      if (response.success) {
        // final lookingFor =
        //     (response.data?['lookingFor'] as List?)
        //         ?.map((e) => e.toString())
        //         .toList();

        // prefeence.value = prefeence.value.copyWith(lookingFor: lookingFor);
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
      final response = await _profileServices.addQualification(
        qualification: qualification,
      );
      if (response.success) {
        final qualification = UtilMethods.stringParser(
          response.data?['qualification'],
        );

        // personal.value = personal.value.copyWith(qualification: qualification);
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
      print('📤 uploadPhotoW: Starting image upload for $imagePath');
      final response = await _profileServices.uploadImageWithDio(imagePath);
      if (response!.success) {
        final image = response.data!.url ?? '';
        print('📤 uploadPhotoW: Upload success, image URL: $image');
        bool isSuccess = await addPhoto(url: image);
        print('📤 uploadPhotoW: addPhoto returned $isSuccess');
        await getMyProfile(false);
        print(
          '📤 uploadPhotoW: getMyProfile completed, allPfFame.length=${allPfFame.length}',
        );
        return isSuccess;
      } else {
        print('❌ uploadPhotoW: Upload failed');
        Get.back();
        return false;
      }
    } catch (e) {
      print('❌ uploadPhotoW exception: $e');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deleteProfile({required String profileId}) async {
    try {
      final response = await _profileServices.deleteProfile(
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

  Future<bool> addProfileImage({required String url}) async {
    try {
      print('➕ addPhoto: Adding photo with URL: $url');
      final response = await _profileServices.uploadProfileimage(url: url);
      print('➕ addPhoto response success: ${response.success}');
      if (response.success) {
        print('✅ addPhoto: Photo added successfully');
        return true;
      } else {
        print('❌ addPhoto: Failed - ${response.message}');
        Get.back();
        return false;
      }
    } catch (e) {
      print('❌ addPhoto exception: $e');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addPhoto({required String url}) async {
    try {
      print('➕ addPhoto: Adding photo with URL: $url');
      final response = await _profileServices.addPhoto(url: url);
      print('➕ addPhoto response success: ${response.success}');
      if (response.success) {
        print('✅ addPhoto: Photo added successfully');
        return true;
      } else {
        print('❌ addPhoto: Failed - ${response.message}');
        Get.back();
        return false;
      }
    } catch (e) {
      print('❌ addPhoto exception: $e');
      debugPrint(e.toString());
      return false;
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
        // professional.value = professional.value.copyWith(work: response.data);
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
      final response = await _profileServices.addAbout(about: about);
      if (response.success) {
        AppMethods.appPrint(message: response.message);
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

  Future<void> getMyProfile(bool isMain) async {
    try {
      print('👤 getMyProfile: Fetching profile...');
      if (isMain) {
        isProfileLoading(true);
      }

      final response = await _profileServices.getMyProfile();
      if (response.success) {
        final data = response.data;
        if (data != null) {
          basicInfo.value = data.basicInfo!;
          final hallList = data.hallOfFame ?? [];
          allPfFame.value = hallList;
          print(
            '✅ getMyProfile: Updated allPfFame with ${hallList.length} photos: ${hallList.map((e) => e.id).toList()}',
          );
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
      // isImageUploading(true);

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
      final response = await _profileServices.allOfFame(
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
      final response = await _profileServices.addHomeLocation(
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

  // UPDATED METHOD: Fixed the List<String>? assignment error
  Future<void> getCountry({String? search}) async {
    try {
      isLoadingCountries(true);
      final response = await _profileServices.getCountries(search: search);

      if (response.success && response.data != null) {
        // 1. Corrected variable name to 'rawData'
        final List rawData = response.data!;

        // 2. Map through the items safely
        final List<String> names =
            rawData
                .map((item) {
                  // If the item is a Map (which matches the [{name: Afghanistan...}] format you showed)
                  if (item is Map) {
                    return item['name']?.toString() ?? '';
                  }
                  // If the item is already a String
                  return item.toString();
                })
                .where((name) => name.isNotEmpty)
                .toList();

        // 3. Update the RxList
        countryList.assignAll(names);

        print("Countries updated successfully: ${countryList} items");
      }

      isLoadingCountries(false);
    } catch (e) {
      isLoadingCountries(false);
      AppMethods.appPrint(message: "Error fetching countries: $e");
    }
  }

  Future<void> getState({required String country, String? search}) async {
    try {
      isLoadingStates(true);
      final response = await _profileServices.getStates(
        country: country,
        search: search,
      );
      if (response.success && response.data != null) {
        stateList.value = response.data!;
      }
      isLoadingStates(false);
    } catch (e) {
      isLoadingStates(false);
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> getCity({
    required String country,
    required String state,
    String? search,
  }) async {
    try {
      isLoadingCities(true);
      final response = await _profileServices.getCities(
        country: country,
        state: state,
        search: search,
      );
      if (response.success && response.data != null) {
        cityList.value = response.data!;
      }
      isLoadingCities(false);
    } catch (e) {
      isLoadingCities(false);
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

    selectedLookingFor
      ..clear()
      ..add(apiList.first.toCapitalizedWords());

    print("SelectedLookingFor: $selectedLookingFor");
  }

  Future<void> sendEmailOtp(String email) async {
    try {
      // if (isResend.isFalse) {
      //   isLoading(true);
      // }

      final response = await _profileServices.sendEmailOtp(email: email);
      if (response.success) {
        debugPrint(response.message);
        // AppToastMessage.show(title: "OTP", message: response.message);
        // if (isResend.isFalse) {
        //   NavigationHelper.push(OtpScreen());
        // }
      } else {
        // AppToastMessage.show(
        //   isError: true,
        //   title: AppConstants.errorTitle,
        //   message: response.message,
        // );

        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    } finally {
      isResend(false);
      isLoading(false);
    }
  }

  Future<bool> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      isLoading(true);
      final response = await _profileServices.verifyEmailOtp(
        email: email,
        otp: otp,
      );
      if (response.success) {
        debugPrint(response.message);
        return true;
        // AppToastMessage.show(title: "Success", message: response.message);

        // Debug: Check if token was saved
      } else {
        // AppMethods.appPrint(message: response.message.toString());
        // AppToastMessage.show(
        //   isError: true,
        //   title: AppConstants.errorTitle,
        //   message: response.message,
        // );

        otpValue.value = "";
        otpRebuildKey++;
        isOtpEnable.value = false;

        isLoading(false);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      return false;
    } finally {
      isLoading(false);
    }
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
