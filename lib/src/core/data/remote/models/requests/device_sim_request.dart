import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_sim_request.freezed.dart';
part 'device_sim_request.g.dart';

@freezed
class DeviceSimRequest with _$DeviceSimRequest {
  const DeviceSimRequest._();

  const factory DeviceSimRequest({
    required  String simCardNo1,
    @Default('') String? simCardNo2,
  }) = _DeviceSimRequest;

  factory DeviceSimRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceSimRequestFromJson(json);
}

/*
{
        'simCardNo1': simCardNo1,
        'simCardNo2': simCardNo2,
};
*/