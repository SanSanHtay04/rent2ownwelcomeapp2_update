// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginOtpResponseImpl _$$LoginOtpResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginOtpResponseImpl(
      code: json['status_code'] as String? ?? '',
      message: json['status_message'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginOtpResponseImplToJson(
        _$LoginOtpResponseImpl instance) =>
    <String, dynamic>{
      'status_code': instance.code,
      'status_message': instance.message,
    };
