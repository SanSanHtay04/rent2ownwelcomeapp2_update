class CallFrequencyModel {
  late String phoneNo;
  late String frequency;

  CallFrequencyModel({required this.phoneNo, required this.frequency});

  factory CallFrequencyModel.fromJson(Map<String, dynamic> json) =>
      CallFrequencyModel(
          phoneNo: json['phoneNo'], frequency: json['frequency']);

  Map<String, dynamic> toJson() => {
        'phoneNo': phoneNo,
        'frequency': frequency,
      };

  static List<Map<String, dynamic>> toJsonList(List<CallFrequencyModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
