import 'package:matchster/core/network/api_response.dart';
import 'package:matchster/core/network/api_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/auth/models/otp_verification_response.dart';

class LoginService {
  LoginService({required this.baseService});
  final ApiService baseService;

  Future<ApiResponse<void>> sendOtp({required String number}) async {
    return baseService.postRequest(
      path: ApiEndpoints.sendOtp,
      data: {"phoneNumber": number},
    );
  }

  Future<ApiResponse<OtpVerificationResponse>> verifyOtp({
    required String number,
    required String otp,
  }) async {
    return await baseService.postRequest<OtpVerificationResponse>(
      path: ApiEndpoints.verifyOtp,
      data: {"phoneNumber": number, "otp": otp, "action": "login"},
      fromJsonT: (json) => OtpVerificationResponse.fromJson(json),
    );
  }
}
