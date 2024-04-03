class TextMessageFrequencyModel {
  late String phoneNo;
  late String sendFrequency;
  late String receivedFrequency;

  TextMessageFrequencyModel(
      {required this.phoneNo,
      required this.sendFrequency,
      required this.receivedFrequency});

  factory TextMessageFrequencyModel.fromJson(Map<String, dynamic> json) =>
      TextMessageFrequencyModel(
          phoneNo: json['phoneNo'],
          sendFrequency: json['sendFrequency'],
          receivedFrequency: json['receivedFrequency']);

  Map<String, dynamic> toJson() => {
        'phoneNo': phoneNo,
        'sendFrequency': sendFrequency,
        'receivedFrequency': receivedFrequency
      };

  static List<Map<String, dynamic>> toJsonList(
      List<TextMessageFrequencyModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
