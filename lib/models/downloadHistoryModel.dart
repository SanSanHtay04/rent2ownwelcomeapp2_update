class DownloadHistoryModel {
  late String packageName;
  late String appName;
  late String version;

  DownloadHistoryModel(
      {required this.packageName,
      required this.appName,
      required this.version});

  factory DownloadHistoryModel.fromJson(Map<String, dynamic> json) =>
      DownloadHistoryModel(
          packageName: json['packageName'],
          appName: json['appName'],
          version: json['version']);

  Map<String, dynamic> toJson() =>
      {'packageName': packageName, 'appName': appName, 'version': version};

  static List<Map<String, dynamic>> toJsonList(
      List<DownloadHistoryModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
