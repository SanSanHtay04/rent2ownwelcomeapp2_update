import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_request.freezed.dart';
part 'device_info_request.g.dart';

@freezed
class DeviceInfoRequest with _$DeviceInfoRequest {
  const DeviceInfoRequest._();

  const factory DeviceInfoRequest({
    required String deviceType,
    required String brand,
    required String operationSystemVersion,
    required String deviceId,
    required String batteryState,
    required String batteryLevel,
    required String noOfAppsInstalled,
  }) = _DeviceInfoRequest;

  factory DeviceInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoRequestFromJson(json);
}

/*
 {
        'deviceType': deviceType,
        'brand': brand,
        'operationSystemVersion': operationSystemVersion,
        'deviceId': deviceId,
        'batteryState': batteryState,
        'batteryLevel': batteryLevel,
        'noOfAppsInstalled': noOfAppsInstalled
      };

*/
