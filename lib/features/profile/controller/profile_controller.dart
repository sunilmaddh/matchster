// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/extentions/looking_for_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/widgets/bottomsheet/photo_review_bottomsheet.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/models/habit_option.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/profile/models/auto_complete_response.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/models/place_details_response.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/features/profile/view/location/add_location_screen.dart';
import 'package:matchster/features/profile/view/profile_photo_preview_screen.dart';
import 'package:matchster/routes/app_navigation.dart';

class ProfileController extends BaseController {
  ProfileController({required this.profileRepository});
  final ProfileRepository profileRepository;
  RxBool isSelected = false.obs;
  RxList<String> selectedItems = <String>[].obs;
  RxList<String> selectedInterests = <String>[].obs;
  RxList<String> selectedLanguage = <String>[].obs;
  RxString selectedLookingFor = "".obs;
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

  RxList<String> countryList = <String>[].obs;
  RxList<String> stateList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;
  // Maps name -> isoCode for states
  final Map<String, String> stateIsoMap = {};
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
  final TextEditingController aboutController = TextEditingController();
  RxBool isResend = false.obs;
  @override
  RxBool isLoading = false.obs;
  RxInt otpRebuildKey = 0.obs;

  void clearData() {
    jobTtileController.clear();
    companyController.clear();
    aboutController.clear();
    isAboutEnable.value = false;
    selectedDrinking.value = "";
    selectedSmoke.value = "";
    selectedInterests.clear();
    selectedItems.clear();
    selectedLanguage.clear();
    selectedLooking.value = "";
    selectedLookingFor.value = "";
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
        await getMyProfile(false);
        AppNavigation.back();
      } else {
        setError(response.message);
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
        await getMyProfile(false);
        AppNavigation.back();
      } else {
        setError(response.message);
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
        await getMyProfile(false);
        AppNavigation.back();
      } else {
        setError(response.message);
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
        AppNavigation.back();
        AppNavigation.back();
      } else {
        setError(response.message);
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
        await getMyProfile(false);
        AppNavigation.back();
      } else {
        setError(response.message);
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
        AppNavigation.back();
      } else {
        setError(response.message);
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
        AppNavigation.back();
      } else {
        setError(response.message);
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
        AppNavigation.back();
      } else {
        setError(response.message);
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
        AppNavigation.back();
      } else {
        setError(response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> addLookingFor({required String lookingFor}) async {
    try {
      final response = await profileRepository.addLooking(
        lookingFor: lookingFor.toSnakeCaseLowerCase(),
      );

      debugPrint(response.success.toString());
      if (!response.success) {
        setError(response.message);
      }

      if (response.success) {
        await getMyProfile(false);
        AppNavigation.back();
        selectedLookingFor.value = "";
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
        AppNavigation.back();
      } else {
        setError(response.message);
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

  Future<bool> addProfileImage({required String url}) async {
    try {
      final response = await profileRepository.uploadImageWithDio(url);

      if (response!.success) {
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
        AppNavigation.back();
      } else {
        setError(response.message);
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
    }
  }

  Future<void> autoCompleteLocation({required String query}) async {
    try {
      final response = await profileRepository.autoCompleteSearchLocation(
        query: query,
      );
      if (response.success) {
        if (response.data != null) {
          autoCompleteResponse.value = response.data!;
        } else {
          autoCompleteResponse.clear();
        }
      } else {
        setError(response.message);
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
        setError(response.message);
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
          final hallList = data.hallOfFame ?? [];
          final profilePicUrl = data.basicInfo?.profilePic?.url;
          final profilePicId = data.basicInfo?.profilePic?.id;
          if (profilePicUrl != null &&
              profilePicUrl.isNotEmpty &&
              hallList.every((e) => e.id != profilePicId)) {
            allPfFame.value = [
              HallOfFame(
                url: profilePicUrl,
                type: data.basicInfo?.profilePic?.type,
                id: profilePicId,
                position: 1,
              ),
              ...hallList,
            ];
          } else {
            allPfFame.value = hallList;
          }
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
      } else {
        setError(response.message);
        isProfileLoading(false);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      isProfileLoading(false);
    } finally {
      isAboutEnable.value = false;
    }
  }

  Future<bool> isFaceClear(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faces = await faceDetector.processImage(inputImage);

    if (faces.length != 1) return false;

    final face = faces.first;
    final imageSize = await _getImageSize(image);
    final faceRect = face.boundingBox;

    final edgeMargin = faceRect.width * 0.08;

    if (faceRect.left <= edgeMargin ||
        faceRect.top <= edgeMargin ||
        faceRect.right >= imageSize.width - edgeMargin ||
        faceRect.bottom >= imageSize.height - edgeMargin) {
      return false;
    }

    if ((face.leftEyeOpenProbability ?? 1) < 0.5 ||
        (face.rightEyeOpenProbability ?? 1) < 0.5) {
      return false;
    }

    return true;
  }

  Future<Size> _getImageSize(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return Size(frame.image.width.toDouble(), frame.image.height.toDouble());
  }

  Future<void> validateAndUploadPhoto({required File file}) async {
    try {
      isImageUploading(true);

      final isValid = await isFaceClear(file);

      if (!isValid) {
        isImageUploading(false);

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
        return;
      }

      final success = await uploadPhotoW(imagePath: file.path);
      isImageUploading(false);

      if (success) {
        Get.back(result: {'success': true});
      } else {
        setError("Photo upload failed. Please try again.");

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
      }
    } catch (e) {
      isImageUploading(false);
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<void> processSelectedFiles(List<File> selectedFiles) async {
    int index = 0;

    while (index < selectedFiles.length) {
      final result = await Get.to<Map<String, dynamic>>(
        () => ProfilePhotoPreviewScreen(
          imageFile: selectedFiles[index],
          imageIndex: index,
        ),
      );

      if (result == null) break;

      if (result['success'] == true) {
        index++;
      } else if (result['retryFile'] != null) {
        selectedFiles[index] = result['retryFile'] as File;
      } else {
        break;
      }
    }
  }

  Future<bool> allOfFameUpload({required List<String> imageUrlList}) async {
    try {
      final response = await profileRepository.allOfFame(
        imageUrlList: imageUrlList,
      );
      if (response.success) {
        return true;
      } else {}
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  RxList<InshortList> inshortList = <InshortList>[].obs;
  Future<void> _updateInShort() async {
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
            .toSet()
            .toList();

    selectedLanguage
      ..clear()
      ..addAll(formattedList);
  }

  Future<void> setLookingFromApi(String? apiValue) async {
    if (apiValue == null || apiValue.trim().isEmpty) return;

    final match = RelationshipIntentEnumX.fromApi(apiValue);
    selectedLookingFor.value = match?.label ?? apiValue;
    // ..clear()
    // ..add(match?.label ?? apiValue);
  }

  Future<void> swapFames({
    required int position1,
    required int position2,
  }) async {
    try {
      await profileRepository.swapFames(
        position1: position1,
        position2: position2,
      );
      await getMyProfile(false);
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
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
