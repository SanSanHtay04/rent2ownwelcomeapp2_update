class AppUsagePatternModel {
  late String appName;
  late String duration;
  late String timeFrom;
  late String timeTo;

  AppUsagePatternModel(
      {required this.appName,
      required this.duration,
      required this.timeFrom,
      required this.timeTo});

  factory AppUsagePatternModel.fromJson(Map<String, dynamic> json) =>
      AppUsagePatternModel(
          appName: json['appName'],
          duration: json['duration'],
          timeFrom: json['timeFrom'],
          timeTo: json['timeTo']);

  Map<String, dynamic> toJson() => {
        'appName': appName,
        'duration': duration,
        'timeFrom': timeFrom,
        'timeTo': timeTo
      };

  static List<Map<String, dynamic>> toJsonList(
      List<AppUsagePatternModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
