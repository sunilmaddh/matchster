import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/features/moduls/auth/login/services/login_service.dart';
import 'package:matchster/features/moduls/auth/login/view/otp_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/view/onboard_screen.dart';
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
  TextEditingController controller = TextEditingController();
  Future<void> sendOtp(String number) async {
    try {
      final response = await _loginService.sendOtp(number: number);
      if (response.success) {
        debugPrint(response.message);
        NavigationHelper.push(OtpScreen());
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> verifyOtp({required String number, required String otp}) async {
    try {
      AppToastMessage.show(title: "Otp", message: number + otp);
      final response = await _loginService.verifyOtp(number: number, otp: otp);
      if (response.success) {
        AppToastMessage.show(title: "Success", message: response.message);
        AppNavigation.off(AppRoutes.onboardScreen);
      } else {
        AppToastMessage.show(
          title: AppConstants.errorTitle,
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
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
