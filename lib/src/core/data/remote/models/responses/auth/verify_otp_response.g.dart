// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyOtpResponseImpl _$$VerifyOtpResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpResponseImpl(
      code: json['status_code'] as String? ?? '',
      message: json['status_message'] as String? ?? '',
      accessToken: json['access_token'] as String,
      expiration: json['token_expiration'] as num? ?? 0,
    );

Map<String, dynamic> _$$VerifyOtpResponseImplToJson(
        _$VerifyOtpResponseImpl instance) =>
    <String, dynamic>{
      'status_code': instance.code,
      'status_message': instance.message,
      'access_token': instance.accessToken,
      'token_expiration': instance.expiration,
    };
