import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
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
import 'package:matchster/features/profile/view/profile/profile_update_screen/profile_photo_preview_screen.dart';

class ProfileController extends BaseController {
  ProfileController({required this.profileRepository});

  final ProfileRepository profileRepository;

  late final FaceDetector _faceDetector;

  final Rxn<MyProfilResponse> profile = Rxn<MyProfilResponse>();
  final RxList<HallOfFame> hallOfFames = <HallOfFame>[].obs;
  final RxList<AutoCompleteResponse> autoCompleteList =
      <AutoCompleteResponse>[].obs;
  final Rxn<PlaceDetailsResponse> placeDetails = Rxn<PlaceDetailsResponse>();
  final RxList<InshortList> inshortList = <InshortList>[].obs;

  BasicInfo? get basicInfo => profile.value?.basicInfo;
  Lifestyle? get lifestyle => profile.value?.lifestyle;
  Preferences? get preferences => profile.value?.preferences;
  Personal? get personal => profile.value?.personal;
  Professional? get professional => profile.value?.professional;
  Bio? get bio => profile.value?.bio;
  Locations? get locations => profile.value?.locations;
  Meta? get meta => profile.value?.meta;
  final RxBool isPageLoading = false.obs;
  final RxBool isButtonLoading = false.obs;
  final RxBool isEnable = false.obs;
  final RxInt selectedEduIndex = 0.obs;
  final RxString qualification = "".obs;
  final RxString height = "".obs;
  final RxDouble feet = 0.0.obs;
  final RxDouble cm = 0.0.obs;

  CurrentLocation? get currentLocation => locations?.currentLocation;
  HomeTown? get homeTown => locations?.homeTown;

  @override
  void onInit() {
    super.onInit();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableClassification: true,
        enableTracking: false,
        minFaceSize: 0.15,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  @override
  void onClose() {
    _faceDetector.close();
    super.onClose();
  }

  Future<bool> getMyProfile({bool showLoader = true}) async {
    try {
      if (showLoader) {
        isPageLoading(true);
      }

      final response = await profileRepository.getMyProfile();

      if (!response.success || response.data == null) {
        setError(response.message);
        return false;
      }

      profile.value = response.data!;
      hallOfFames.assignAll(response.data!.hallOfFame ?? []);
      _buildInShortList();

      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    } finally {
      isPageLoading(false);
    }
  }

  Future<bool> addWorkout(String workout) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addWorkout(workout: workout.toLowerCase()),
    );
  }

  Future<bool> addDrinking(String drinking) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addDrinking(drinking: drinking.toLowerCase()),
    );
  }

  Future<bool> addSmoking(String smoking) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addSmoking(smoking: smoking.toLowerCase()),
    );
  }

  Future<bool> addHeight({required double feet, required double cm}) async {
    return _submitAndRefresh(
      action: () => profileRepository.addHeight(feet: feet, cm: cm),
    );
  }

  Future<bool> addInterests(List<String> interests) async {
    return _submitAndRefresh(
      action: () => profileRepository.addInterests(interests: interests),
    );
  }

  Future<bool> addLanguages(List<String> languages) async {
    return _submitAndRefresh(
      action: () => profileRepository.addLanguages(languages: languages),
    );
  }

  Future<bool> addZodiacSign(String zodiacSign) async {
    return _submitAndRefresh(
      action: () => profileRepository.addZodiacsign(zodiacsign: zodiacSign),
    );
  }

  Future<bool> addReligion(String religion) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addReligion(
            religion: religion.toSnakeCaseLowerCase(),
          ),
    );
  }

  Future<bool> addVisibility(String visibility) async {
    return _submitAndRefresh(
      action: () => profileRepository.addVisibility(visibility: visibility),
    );
  }

  Future<bool> addLookingFor(String lookingFor) async {
    return _submitAndRefresh(
      action: () => profileRepository.addLooking(lookingFor: lookingFor),
    );
  }

  Future<bool> addQualification(String qualification) async {
    return _submitAndRefresh(
      action:
          () =>
              profileRepository.addQualification(qualification: qualification),
    );
  }

  Future<bool> addWork({
    required String jobTitle,
    required String company,
  }) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addWork(jobTitle: jobTitle, company: company),
    );
  }

  Future<bool> addAbout(String about) async {
    return _submitAndRefresh(
      action: () => profileRepository.addAbout(about: about),
    );
  }

  Future<bool> addHomeLocation({
    required String city,
    required String state,
    required String country,
  }) async {
    return _submitAndRefresh(
      action:
          () => profileRepository.addHomeLocation(
            city: city,
            state: state,
            country: country,
          ),
    );
  }

  Future<List<AutoCompleteResponse>?> autoCompleteLocation({
    required String query,
  }) async {
    try {
      if (query.trim().isEmpty) {
        autoCompleteList.clear();
        return [];
      }

      final response = await profileRepository.autoCompleteSearchLocation(
        query: query,
      );

      if (response.success && response.data != null) {
        autoCompleteList.assignAll(response.data!);
        return response.data;
      } else {
        autoCompleteList.clear();
        setError(response.message);
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
    }
    return [];
  }

  Future<bool> fetchPlaceDetails({required String placeId}) async {
    try {
      final response = await profileRepository.placeDetails(placeId: placeId);

      if (!response.success || response.data == null) {
        setError(response.message);
        return false;
      }

      placeDetails.value = response.data!;
      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    }
  }

  Future<bool> uploadPhoto(String imagePath) async {
    try {
      isButtonLoading(true);

      final response = await profileRepository.uploadImageWithDio(imagePath);
      if (response == null || !response.success || response.data?.url == null) {
        return false;
      }

      final addPhotoResponse = await profileRepository.addPhoto(
        url: response.data!.url!,
      );

      if (!addPhotoResponse.success) {
        setError(addPhotoResponse.message);
        return false;
      }

      await getMyProfile(showLoader: false);
      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    } finally {
      isButtonLoading(false);
    }
  }

  Future<bool> deleteProfilePhoto(String profileId) async {
    try {
      isButtonLoading(true);

      final response = await profileRepository.deleteProfile(
        profileId: profileId,
      );

      if (!response.success) {
        setError(response.message);
        return false;
      }

      await getMyProfile(showLoader: false);
      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    } finally {
      isButtonLoading(false);
    }
  }

  // Future<bool> isFaceClear(File image) async {
  //   final inputImage = InputImage.fromFile(image);
  //   final faces = await _faceDetector.processImage(inputImage);

  //   if (faces.length != 1) return false;

  //   final face = faces.first;

  //   if ((face.leftEyeOpenProbability ?? 0) < 0.5 ||
  //       (face.rightEyeOpenProbability ?? 0) < 0.5) {
  //     return false;
  //   }

  //   if ((face.headEulerAngleY ?? 0).abs() > 15 ||
  //       (face.headEulerAngleZ ?? 0).abs() > 15) {
  //     return false;
  //   }

  //   return true;
  // }

  // Future<bool> uploadValidatedPhoto(File file) async {
  //   try {
  //     final valid = await isFaceClear(file);
  //     if (!valid) return false;

  //     return uploadPhoto(file.path);
  //   } catch (e) {
  //     AppMethods.appPrint(message: e.toString());
  //     setError(e.toString());
  //     return false;
  //   }
  // }

  Future<bool> uploadHallOfFame(List<String> imageUrlList) async {
    try {
      isButtonLoading(true);

      final response = await profileRepository.allOfFame(
        imageUrlList: imageUrlList,
      );

      if (!response.success) {
        setError(response.message);
        return false;
      }

      await getMyProfile(showLoader: false);
      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    } finally {
      isButtonLoading(false);
    }
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
      await getMyProfile();
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }

  Future<bool> _submitAndRefresh({
    required Future<dynamic> Function() action,
  }) async {
    try {
      isButtonLoading(true);

      final response = await action();

      if (!response.success) {
        setError(response.message);
        return false;
      }

      await getMyProfile(showLoader: false);
      return true;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError(e.toString());
      return false;
    } finally {
      isButtonLoading(false);
    }
  }

  void _buildInShortList() {
    inshortList.clear();

    final basic = basicInfo;
    final life = lifestyle;
    final person = personal;

    if (basic?.gender?.isNotEmpty == true) {
      final value = GenderEnumX.fromApi(basic!.gender!);
      if (value != null) {
        inshortList.add(InshortList(text: basic.gender!, img: value.emoji));
      }
    }

    if (life?.smoking?.isNotEmpty == true) {
      final freq = frequencyFromApi(life!.smoking!);
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

    if (life?.drinking?.isNotEmpty == true) {
      final freq = frequencyFromApi(life!.drinking!);
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

    if (person?.religion?.isNotEmpty == true) {
      final value = ReligionEnumX.fromApi(person!.religion!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if (person?.zodiacSign?.isNotEmpty == true) {
      final value = ZodiacEnumX.fromApi(person!.zodiacSign!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if (basic?.height?.isNotEmpty == true) {
      final value = HeightEnumExt.fromApi(basic!.height!);
      if (value != null) {
        inshortList.add(InshortList(text: basic.height!, img: value.emoji));
      }
    }
  }

  void deleteProfile({required String profileId}) {}

  Future<bool> isFaceClear(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faces = await _faceDetector.processImage(inputImage);

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

    // if ((face.headEulerAngleX ?? 0).abs() > 10 ||
    //     (face.headEulerAngleY ?? 0).abs() > 10 ||
    //     (face.headEulerAngleZ ?? 0).abs() > 10) {
    //   return false;
    // }

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
      // isImageUploading(true);

      final isValid = await isFaceClear(file);

      if (!isValid) {
        // isImageUploading(false);

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
        return;
      }

      final success = await uploadPhoto(file.path);
      // isImageUploading(false);

      if (success) {
        Get.back(result: {'success': true});
      } else {
        AppToastMessage.show(
          title: "Error",
          message: "Photo upload failed. Please try again.",
          isError: true,
        );

        PhotoReviewBottomsheet.show(
          onImageSelected: (selectedImage) {
            Get.back(); // close bottomsheet
            Get.back(result: {'success': false, 'retryFile': selectedImage});
          },
        );
      }
    } catch (e) {
      // isImageUploading(false);
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
}
