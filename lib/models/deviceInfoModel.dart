class DeviceInfoModel {
  late String deviceType;
  late String brand;
  late String operationSystemVersion;
  late String deviceId;
  late String batteryState;
  late String batteryLevel;
  late String noOfAppsInstalled;

  DeviceInfoModel(
      {required this.deviceType,
      required this.brand,
      required this.operationSystemVersion,
      required this.deviceId,
      required this.batteryState,
      required this.batteryLevel,
      required this.noOfAppsInstalled});

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      DeviceInfoModel(
          deviceType: json['deviceType'],
          brand: json['brand'],
          operationSystemVersion: json['operationSystemVersion'],
          deviceId: json['deviceId'],
          batteryState: json['batteryState'],
          batteryLevel: json['batteryLevel'],
          noOfAppsInstalled: json['noOfAppsInstalled']);

  Map<String, dynamic> toJson() => {
        'deviceType': deviceType,
        'brand': brand,
        'operationSystemVersion': operationSystemVersion,
        'deviceId': deviceId,
        'batteryState': batteryState,
        'batteryLevel': batteryLevel,
        'noOfAppsInstalled': noOfAppsInstalled
      };

  static List<Map<String, dynamic>> toJsonList(List<DeviceInfoModel> list) =>
      list.map((e) => e.toJson()).toList();
}
