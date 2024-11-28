class StoreSMSLogModel {
  late String status;
  late String sender;
  late String receiver;
  late String message;
  late DateTime date;

  StoreSMSLogModel(
      {required this.status,
      required this.sender,
      required this.receiver,
      required this.message,
      required this.date});

  factory StoreSMSLogModel.fromJson(Map<String, dynamic> json) =>
      StoreSMSLogModel(
        status: json['status'],
        sender: json['sender'],
        receiver: json['receiver'],
        message: json['message'],
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'sender': sender,
        'receiver': receiver,
        'message': message,
        'date': date.toIso8601String(),
      };

  static List<Map<String, dynamic>> toJsonList(List<StoreSMSLogModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
