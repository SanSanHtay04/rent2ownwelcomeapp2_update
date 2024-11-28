import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_frequency_request.freezed.dart';
part 'sms_frequency_request.g.dart';

@freezed
class SmsFrequencyRequest with _$SmsFrequencyRequest {
  const SmsFrequencyRequest._();

  const factory SmsFrequencyRequest({
    required String phoneNo,
    required String sendFrequency,
    required String receivedFrequency,
  }) = _SmsFrequencyRequest;

  factory SmsFrequencyRequest.fromJson(Map<String, dynamic> json) =>
      _$SmsFrequencyRequestFromJson(json);
}

/*
  late String status;
  late String sender;
  late String receiver;
  late String message;

 {
        'phoneNo': phoneNo,
        'sendFrequency': sendFrequency,
        'receivedFrequency': receivedFrequency
      };
*/
