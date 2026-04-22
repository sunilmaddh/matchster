import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/error/app_exception.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/token_debug.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/model/response/otp_verification_response.dart';
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
  final RxString countryCode = AppStrings.defaultCountryCode.obs;
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
      await authRepository.getOtp(phoneNumber: number);
    } on AppException catch (e) {
      setError(e.toString());
    } catch (e) {
      setError(e.toString());
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
      await _handleOtpSuccess(response);
    } on AppException catch (e) {
      _resetVerifyOtp();
      setError(e.toString());
    } catch (e) {
      _resetVerifyOtp();
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> _handleOtpSuccess(
    BaseResponse<OtpVerificationResponse> response,
  ) async {
    await _saveSessionData(response);
    await _handleOnboardingFlow(response);
  }

  Future<void> _saveSessionData(
    BaseResponse<OtpVerificationResponse> response,
  ) async {
    await MatchsterLocalStorage.instance.saveAccessToken(
      response.data?.accessToken ?? '',
    );
    await MatchsterLocalStorage.instance.saveProfilePopupShown(false);
    await TokenDebug.checkToken();
  }

  Future<void> _handleOnboardingFlow(
    BaseResponse<OtpVerificationResponse> response,
  ) async {
    final pages = response.data?.pages;
    final pagesValue = response.data?.values;
    if (pages == null) {
      throw AppException(AppStrings.somethingWentWrongOtp);
    }
    final OnboardController onboardController = Get.find<OnboardController>();
    await onboardController.setOnboardPages(pages);
    if (pagesValue != null) {
      await onboardController.setPagesValue(pagesValue);
    }
    final bool allCompleted = onboardController.allCompleted;
    if (allCompleted) {
      await MatchsterLocalStorage.instance.saveUserOnboard(true);
      navigateOffAll(AppRoutes.landingScreen);
    } else {
      await MatchsterLocalStorage.instance.saveUserOnboard(false);
      navigateOff(AppRoutes.onboardScreen);
    }
  }

  Future<void> _resetVerifyOtp() async {
    otpValue.value = '';
    otpRebuildKey.value++;
    isOtpEnable.value = false;
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

        setSuccess(AppStrings.googleSignInSuccess);
        navigateTo(AppRoutes.onboardScreen);
      } else {
        setError(AppStrings.googleSignInCancelled);
      }
    } catch (e) {
      debugPrint(e.toString());
      setError(AppStrings.googleSignInError);
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
