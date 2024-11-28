import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_log_request.freezed.dart';
part 'sms_log_request.g.dart';

@freezed
class SmsLogRequest with _$SmsLogRequest {
  const SmsLogRequest._();

  const factory SmsLogRequest({
    required String status,
    required String sender,
    required String receiver,
    required String message,
    required String date,
  }) = _SmsLogRequest;

  factory SmsLogRequest.fromJson(Map<String, dynamic> json) =>
      _$SmsLogRequestFromJson(json);
}

/*
{
        'status': status,
        'sender': sender,
        'receiver': receiver,
        'message': message
      };
*/