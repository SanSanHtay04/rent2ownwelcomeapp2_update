
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_frequency_request.freezed.dart';
part 'call_frequency_request.g.dart';

@freezed
class CallFrequencyRequest with _$CallFrequencyRequest {
  const CallFrequencyRequest._();

  const factory CallFrequencyRequest(
      {required String phoneNo,
      required String frequency,
    }) = _CallFrequencyRequest;

  factory CallFrequencyRequest.fromJson(Map<String, dynamic> json) =>
      _$CallFrequencyRequestFromJson(json);
}

/*
 {
        'phoneNo': phoneNo,
        'frequency': frequency,
      };
*/
