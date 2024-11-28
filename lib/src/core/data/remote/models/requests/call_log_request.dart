import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_log_request.freezed.dart';
part 'call_log_request.g.dart';

@freezed
class CallLogRequest with _$CallLogRequest {
  const CallLogRequest._();

  const factory CallLogRequest({
    required  String phoneNo,
    required String name,
    required String callType,
    required String date,
    required String duration,
    required String simDisplayName
    
  }) = _CallLogRequest;

  factory CallLogRequest.fromJson(Map<String, dynamic> json) =>
      _$CallLogRequestFromJson(json);
}

/*
{
        'phoneNo': phoneNo,
        'name': name,
        'callType': callType,
        'date': date,
        'duration': duration,
        'simDisplayName': simDisplayName
      };
*/