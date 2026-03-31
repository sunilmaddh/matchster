import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';

class ProfileDetailsListController extends BaseController {
  ProfileDetailsListController({
    required this.profileController,
    required this.controller,
  });

  final ProfileController profileController;
  final ProfileFormController controller;

  late Personal personal;
  late Preferences preference;
  late Professional professional;
  late BasicInfo basicInfo;

  void setData({
    required Personal personalData,
    required Preferences preferenceData,
    required Professional professionalData,
    required BasicInfo basicInfoData,
  }) {
    personal = personalData;
    preference = preferenceData;
    professional = professionalData;
    basicInfo = basicInfoData;
  }

  void onTapZodiac() {
    controller.selectedZodiac.value = personal.zodiacSign ?? '';
  }

  void onTapReligion() {
    controller.selectedReligion.value = personal.religion ?? '';
  }

  void onTapVisibility() {
    controller.selectedVisibility.value = preference.visibility ?? '';
  }

  void onTapLookingFor() {
    if (preference.lookingFor != null) {
      controller.setLookingFromApi(preference.lookingFor);
    } else {
      controller.selectedLookingFor.value = "";
    }
  }

  void onTapHeight() {
    profileController.height.value = basicInfo.height ?? '';
  }

  void onTapEducation() {
    final qualification = personal.qualification ?? '';
    profileController.qualification.value = qualification;

    if (qualification.isEmpty) {
      profileController.selectedEduIndex.value = -1;
      return;
    }

    final index = CommonLists.studieList.indexWhere(
      (element) =>
          element.toLowerCase() ==
          qualification.replaceAll('_', ' ').toLowerCase(),
    );

    profileController.selectedEduIndex.value = index;
  }

  void onTapWork() {
    final work = professional.work;

    if (work?.jobTitle?.isNotEmpty ?? false) {
      controller.jobTitleController.text = work?.jobTitle ?? '';
      controller.companyController.text = work?.company ?? '';
    } else {
      controller.jobTitleController.clear();
      controller.companyController.clear();
    }
  }
}
