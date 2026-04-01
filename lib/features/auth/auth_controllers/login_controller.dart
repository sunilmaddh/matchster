import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/services/firebase_auth_service.dart';
import 'package:matchster/routes/app_routes.dart';

class LoginController extends BaseController {
  LoginController({required this.authRepositry});

  final AuthRepository authRepositry;

  final RxBool isLoginWithMobile = false.obs;
  final RxString otpValue = ''.obs;
  final RxBool isEnable = false.obs;
  final RxBool isOtpEnable = false.obs;
  final RxBool isAccessMyAccount = false.obs;
  final RxString countryCode = '+91'.obs;
  final RxString phoneNumber = ''.obs;
  final RxBool isResend = false.obs;
  final RxBool isAccessAccount = false.obs;
  final RxInt otpRebuildKey = 0.obs;

  Future<void> sendOtp(String number) async {
    try {
      showLoading(true);

      final response = await authRepositry.getOtp(phoneNumber: number);

      if (response.success) {
        setSuccess(response.message);
      } else {
        setError(response.message);
      }
    } catch (e) {
      debugPrint('${AppStrings.sendOtpError}: $e');
      setError(AppStrings.failedToSendOtp);
    } finally {
      isResend.value = false;
      showLoading(false);
    }
  }

  Future<void> verifyOtp({required String number, required String otp}) async {
    try {
      showLoading(true);

      final response = await authRepositry.verifyOtp(
        phoneNumber: number,
        otp: otp,
      );

      if (response.success && response.data != null) {
        await MatchsterLocalStorage.instance.saveAccessToken(
          response.data!.accessToken.toString(),
        );

        final pages = response.data!.pages;
        final pagesValue = response.data!.values;

        if (pages != null && pagesValue != null) {
          final onboardController = Get.find<OnboardController>();
          await onboardController.setOnboardPages(pages);
          await onboardController.setPagesValue(pagesValue);

          if (onboardController.allCompleted) {
            MatchsterLocalStorage.instance.saveUserOnboard(true);
            navigateOff(AppRoutes.landingScreen);
          } else {
            MatchsterLocalStorage.instance.saveUserOnboard(false);
            navigateOff(AppRoutes.onboardScreen);
          }
        } else {
          setError(AppStrings.invalidOnboardingData);
        }
      } else {
        otpValue.value = '';
        otpRebuildKey.value++;
        isOtpEnable.value = false;
        setError(response.message);
      }
    } catch (e) {
      debugPrint('${AppStrings.verifyOtpError}: $e');
      setError(AppStrings.failedToVerifyOtp);
    } finally {
      showLoading(false);
    }
  }

  Future<void> signWithGoogle() async {
    try {
      showLoading(true);

      final userCredential = await FirebaseAuthService.signWithGoogle();
      if (userCredential != null) {
        navigateTo(AppRoutes.onboardScreen);
      } else {
        setError(AppStrings.googleCancelled);
      }
    } catch (e) {
      debugPrint('${AppStrings.signWithGoogleError}: $e');
      setError(AppStrings.googleFailed);
    } finally {
      showLoading(false);
    }
  }

  void updatePhoneNumber(String value) {
    final clean = value.trim();
    isEnable.value = clean.length == 10;
  }

  Future<void> submitPhone(String number) async {
    phoneNumber.value = number;

    await sendOtp(number);

    navigateTo(AppRoutes.otpScreen);
  }

  void updateCountryCode(String code) {
    if (code.isEmpty) return;

    countryCode.value = code.startsWith('+') ? code : '+$code';
  }
}
