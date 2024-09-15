import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_otp_response.freezed.dart';
part 'login_otp_response.g.dart';

@freezed
class LoginOtpResponse with _$LoginOtpResponse {
  const LoginOtpResponse._();

  const factory LoginOtpResponse({
    @JsonKey(name: 'status_code') @Default('')  String? statusCode,
    @JsonKey(name: 'status_message') @Default('')  String? statusMessage,
  }) = _LoginOtpResponse;

  factory LoginOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginOtpResponseFromJson(json);
}

/*
{
    "status_code": "SUCCESS",
    "status_message": "Successfully sent OTP to phone number 09454457120 of device with IMEI number testing. It will expire in 10 minutes."
}
*/
