class StoreSMSLogModel {
  late String status;
  late String sender;
  late String receiver;
  late String message;

  StoreSMSLogModel(
      {required this.status,
      required this.sender,
      required this.receiver,
      required this.message});

  factory StoreSMSLogModel.fromJson(Map<String, dynamic> json) =>
      StoreSMSLogModel(
          status: json['status'],
          sender: json['sender'],
          receiver: json['receiver'],
          message: json['message']);

  Map<String, dynamic> toJson() => {
        'status': status,
        'sender': sender,
        'receiver': receiver,
        'message': message
      };

  static List<Map<String, dynamic>> toJsonList(List<StoreSMSLogModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
