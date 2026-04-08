import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/moduls/auth/login/models/otp_verification_response.dart';

class LoginService {
  final BaseService _baseService = BaseService();

  Future<BaseResponse<void>> sendOtp({required String number}) async {
    return _baseService.postRequest(
      path: ApiEndpoints.sendOtp,
      data: {"phoneNumber": number},
    );
  }

  Future<BaseResponse<OtpVerificationResponse>> verifyOtp({
    required String number,
    required String otp,
  }) async {
    return await _baseService.postRequest<OtpVerificationResponse>(
      path: ApiEndpoints.verifyOtp,
      data: {"phoneNumber": number, "otp": otp, "action": "login"},
      fromJsonT: (json) => OtpVerificationResponse.fromJson(json),
    );
  }
}
