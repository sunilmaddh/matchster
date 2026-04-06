import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/token_debug.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/services/firebase_services.dart';
import 'package:matchster/routes/app_routes.dart';

class LoginController extends BaseController {
  LoginController({required this.authRepository});

  final AuthRepository authRepository;

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

  final TextEditingController controller = TextEditingController();

  Future<void> sendOtp(String number) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await authRepository.getOtp(phoneNumber: number);

      if (response.success) {
        debugPrint(response.message);
        setSuccess(response.message ?? 'OTP sent successfully');
      } else {
        setError(response.message ?? 'Failed to send OTP');
      }
    } catch (e) {
      debugPrint(e.toString());
      setError('Something went wrong while sending OTP');
    } finally {
      isResend.value = false;
      showLoading(false);
    }
  }

  Future<void> verifyOtp({required String number, required String otp}) async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final response = await authRepository.verifyOtp(
        phoneNumber: number,
        otp: otp,
      );

      if (response.success) {
        await MatchsterLocalStorage.instance.saveAccessToken(
          response.data?.accessToken.toString() ?? '',
        );
        await MatchsterLocalStorage.instance.saveProfilePopupShown(false);

        await TokenDebug.checkToken();
        final pages = response.data?.pages;
        final pagesValue = response.data?.values;
        debugPrint("Onboard screen page 1");
        if (pages != null) {
          debugPrint("Onboard screen page 2");
          final onboardController = Get.find<OnboardController>();
          await onboardController.setOnboardPages(pages);
          debugPrint("Onboard screen page 3");
          if (pagesValue != null) {
            await onboardController.setPagesValue(pagesValue);
          }
          debugPrint("Onboard screen page 4");
          final allCompleted = onboardController.allCompleted;

          if (allCompleted) {
            debugPrint("Onboard screen page 5");
            await MatchsterLocalStorage.instance.saveUserOnboard(true);
            setSuccess(response.message ?? 'Login successful');
            navigateOffAll(AppRoutes.landingScreen);
          } else {
            await MatchsterLocalStorage.instance.saveUserOnboard(false);
            debugPrint("Onboard screen page 6");
            setSuccess(response.message ?? 'OTP verified successfully');
            navigateOff(AppRoutes.onboardScreen);
          }
        } else {
          debugPrint("Onboard screen page 7");
          setSuccess(response.message ?? 'OTP verified successfully');
        }
      } else {
        otpValue.value = '';
        otpRebuildKey.value++;
        isOtpEnable.value = false;
        setError(response.message ?? 'Invalid OTP');
      }
    } catch (e) {
      debugPrint(e.toString());
      setError('Something went wrong while verifying OTP');
    } finally {
      showLoading(false);
    }
  }

  Future<void> signWithGoogle() async {
    try {
      showLoading(true);
      clearError();
      clearSuccess();

      final userCredential = await FirebaseServices.signWithGoogle();

      if (userCredential != null) {
        await MatchsterLocalStorage.instance.saveProfilePopupShown(false);
        debugPrint('User name ${userCredential.user?.displayName}');

        setSuccess('Google sign-in successful');
        navigateTo(AppRoutes.onboardScreen);
      } else {
        setError('Google sign-in cancelled');
      }
    } catch (e) {
      debugPrint(e.toString());
      setError('Something went wrong during Google sign-in');
    } finally {
      showLoading(false);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
