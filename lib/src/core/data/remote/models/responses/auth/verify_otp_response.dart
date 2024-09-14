import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_response.freezed.dart';
part 'verify_otp_response.g.dart';

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
  const VerifyOtpResponse._();

  const factory VerifyOtpResponse({
    @JsonKey(name: 'status_code') @Default('') String? code,
    @JsonKey(name: 'status_message') @Default('') String? message,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_expiration') @Default(0) num expiration,
  }) = _VerifyOtpResponse;

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
}

/*
{
    "status_code": "SUCCESS",
    "status_message": "Successfully logged in.",
    "access_token": "22618|2S5tG0VC3stb5pWS1VxmGj8O9JZoyiOKI1RwjRvN",
    "token_expiration": 86400
}
*/
