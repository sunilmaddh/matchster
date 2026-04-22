import 'package:matchster/core/error/app_exception.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/auth/model/response/otp_verification_response.dart';
import 'package:matchster/features/auth/services/login_service.dart';

class AuthRepository {
  AuthRepository({required this.loginService});
  final LoginService loginService;
  Future<BaseResponse<void>> getOtp({required String phoneNumber}) async {
    final response = await loginService.sendOtp(number: phoneNumber);
    if (response.success) {
      throw AppException(response.message);
    }
    return response;
  }

  Future<BaseResponse<OtpVerificationResponse>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await loginService.verifyOtp(
      number: phoneNumber,
      otp: otp,
    );
    if (!response.success) {
      throw AppException(response.message);
    }

    return response;
  }
}
