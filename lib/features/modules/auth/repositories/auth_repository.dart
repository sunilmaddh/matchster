import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/modules/auth/models/otp_verification_response.dart';
import 'package:matchster/features/modules/auth/services/login_service.dart';

class AuthRepository {
  AuthRepository({required this.loginService});
  final LoginService loginService;
  Future<BaseResponse<void>> getOtp({required String phoneNumber}) async {
    return await loginService.sendOtp(number: phoneNumber);
  }

  Future<BaseResponse<OtpVerificationResponse>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    return await loginService.verifyOtp(number: phoneNumber, otp: otp);
  }
}
