import 'package:get/get.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/features/profile/controller/profile_base_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileEmailController extends ProfileBaseController {
  ProfileEmailController(
    this.profileController, {
    required this.profileRepository,
  });

  final ProfileRepository profileRepository;
  final ProfileController profileController;

  final RxString otpValue = ''.obs;
  final RxBool isOtpEnable = false.obs;
  final RxBool isResend = false.obs;
  final RxInt otpRebuildKey = 0.obs;
  final RxString email = "".obs;

  Future<void> sendEmailOtp(String email) async {
    try {
      setBusy(true);
      final response = await profileRepository.getEmailOtp(email: email);
      if (!response.success) {
        setErrorMessage(response.message);
      }
      if (response.success) {
        navigateTo(AppRoutes.verifyEmailOtpScreen, arguments: email);
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      isResend.value = false;
      setBusy(false);
    }
  }

  Future<bool> verifyEmailOtp() async {
    try {
      setBusy(true);
      final response = await profileRepository.verifyEmailOtp(
        email: email.value,
        otp: otpValue.value,
      );

      if (response.success) {
        await profileController.getMyProfile(false);
        navigateBack();
        navigateBack();
        return true;
      }

      otpValue.value = '';
      otpRebuildKey.value++;
      isOtpEnable.value = false;
      setErrorMessage(response.message);
      return false;
    } catch (e) {
      setErrorMessage(e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  void setEmail(String value) {
    email.value = value;
  }

  void onOtpChanged(String value) {
    otpValue.value = value;
    isOtpEnable.value = value.length == 4;
  }

  void onOtpCompleted(String otp) {
    otpValue.value = otp;
    isOtpEnable.value = true;
    verifyEmailOtp();
  }

  void onResendTap() {
    isResend.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isResend.value = false;
      otpRebuildKey.value++;
    });
  }
}
