import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService() => _AuthService(ApiClient.client);

  @GET('/issue-otp')
  Future<LoginOtpResponse> otpLogin(@Body() Map<String, dynamic> body);

  @POST('/verify-otp')
  Future<VerifyOtpResponse > verifyOTP(@Body() Map<String, dynamic> body);

  @DELETE('/access_token')
  Future<void> logout();

  // const postPhoneNoToGetOTPEndpoint = "issue-otp";
  // const verifyPhoneNoEndpoint = "verify-otp";
}
