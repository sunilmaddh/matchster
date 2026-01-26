import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/features/moduls/auth/login/services/login_service.dart';
import 'package:matchster/features/moduls/auth/login/view/otp_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/view/onboard_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/view/work_inprogress.dart';
import 'package:matchster/features/moduls/auth/services/firebase_services.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  RxBool isLoginWithMobile = false.obs;
  RxString otpValue = "".obs;
  RxBool isEnable = false.obs;
  RxBool isOtpEnable = false.obs;
  RxBool isAccessMyAccount = false.obs;
  RxString countryCode = "+91".obs;
  RxString phoneNumber = "".obs;
  RxBool isResend = false.obs;
  RxBool isLoading = false.obs;
  TextEditingController controller = TextEditingController();
  Future<void> sendOtp(String number) async {
    try {
      if (isResend.isFalse) {
        isLoading(true);
      }

      final response = await _loginService.sendOtp(number: number);
      if (response.success) {
        debugPrint(response.message);
        AppToastMessage.show(title: "OTP", message: response.message);
        if (isResend.isFalse) {
          NavigationHelper.push(OtpScreen());
        }
      } else {
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );

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

  Future<void> verifyOtp({required String number, required String otp}) async {
    try {
      isLoading(true);
      final response = await _loginService.verifyOtp(number: number, otp: otp);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        await MatchsterLocalStorage.instance.saveAccessToken(
          response.data!.accessToken.toString(),
        );
        final pages = response.data!.pages;
        final pagesValue = response.data!.values;
        if (pages != null) {
          final onboardController = Get.find<OnboardController>();
          await onboardController.setOnboardPages(pages);

          await onboardController.setPagesValue(pagesValue!);
          final allCompleted = onboardController.allCompleted;
          if (allCompleted) {
            //Get.to(() => MaintenceScreen());
            AppNavigation.off(AppRoutes.landingScreen);
          } else {
            AppNavigation.off(AppRoutes.onboardScreen);
          }
        }
      } else {
        AppMethods.appPrint(message: response.message.toString());
        AppToastMessage.show(
          isError: true,
          title: AppConstants.errorTitle,
          message: response.message,
        );
        isLoading(false);
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> signWithGoogle() async {
    try {
      final userCredential = await FirebaseServices.signWithGoogle();
      if (userCredential != null) {
        debugPrint("User name${userCredential.user?.displayName}");
        NavigationHelper.push(OnboardScreen());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
