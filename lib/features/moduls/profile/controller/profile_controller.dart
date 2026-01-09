import 'package:get/get.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/moduls/profile/services/profile_services.dart';

class ProfileController extends GetxController {
  final ProfileServices _profileServices = ProfileServices();
  Future<void> addWorkout({required String workout}) async {
    try {
      final response = await _profileServices.addWorkout(workout: workout);
      if (response.success) {
        AppMethods.appPrint(message: response.message);
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
      final response = await _profileServices.addDrinking(drinking: drinking);
      if (response.success) {
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
        AppMethods.appPrint(message: response.message);
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
}
