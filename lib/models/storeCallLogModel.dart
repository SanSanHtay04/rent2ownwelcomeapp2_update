class StoreCallLogModel {
  late String phoneNo;
  late String name;
  late String callType;
  late String date;
  late String duration;
  late String simDisplayName;

  StoreCallLogModel(
      {required this.phoneNo,
      required this.name,
      required this.callType,
      required this.date,
      required this.duration,
      required this.simDisplayName});

  factory StoreCallLogModel.fromJson(Map<String, dynamic> json) =>
      StoreCallLogModel(
          phoneNo: json['phoneNo'],
          name: json['name'],
          callType: json['callType'],
          date: json['date'],
          duration: json['duration'],
          simDisplayName: json['simDisplayName']);

  Map<String, dynamic> toJson() => {
        'phoneNo': phoneNo,
        'name': name,
        'callType': callType,
        'date': date,
        'duration': duration,
        'simDisplayName': simDisplayName
      };

  static List<Map<String, dynamic>> toJsonList(List<StoreCallLogModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
