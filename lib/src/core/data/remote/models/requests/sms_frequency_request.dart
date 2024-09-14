
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_frequency_request.freezed.dart';
part 'sms_frequency_request.g.dart';

@freezed
class SmsFrequencyRequest with _$SmsFrequencyRequest {
  const SmsFrequencyRequest._();

  const factory SmsFrequencyRequest(
      {required String phoneNo,
      required String sendFrequency,
      required String receivedFrequency,
    }) = _SmsFrequencyRequest;

  factory SmsFrequencyRequest.fromJson(Map<String, dynamic> json) =>
      _$SmsFrequencyRequestFromJson(json);
}

/*
 {
        'phoneNo': phoneNo,
        'sendFrequency': sendFrequency,
        'receivedFrequency': receivedFrequency
      };
*/
