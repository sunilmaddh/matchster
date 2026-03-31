import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_logger.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart'
    show ProfileController;
import 'package:matchster/features/profile/services/profile_services.dart';
import 'package:matchster/routes/app_navigation.dart';

class EmailController extends BaseController {
  EmailController({
    required this.profileService,
    required this.profileController,
  });
  final ProfileService profileService;
  final ProfileController profileController;
  RxBool isOtpEnable = false.obs;
  RxString email = "".obs;
  RxString otpValue = "".obs;
  RxBool isResend = false.obs;
  RxInt otpRebuildKey = 0.obs;
  RxBool isValidEmail = false.obs;

  Future<void> sendEmailOtp(String email) async {
    try {
      final response = await profileService.sendEmailOtp(email: email);
      if (response.success) {
        AppLogger.debug(response.message);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    } finally {
      isResend(false);
      isLoading(false);
    }
  }

  Future<void> verifyEmailOtp() async {
    isLoading(true);
    try {
      if (isOtpEnable.isTrue) {
        var result = await profileService.verifyEmailOtp(
          email: email.value,
          otp: otpValue.value,
        );
        if (result.success) {
          await profileController.getMyProfile();
          AppNavigation.back();
          AppNavigation.back();
        } else {
          // setError(AppStrings.otpVerifyFailed);
        }
      }
    } catch (e) {
      AppLogger.debug(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
