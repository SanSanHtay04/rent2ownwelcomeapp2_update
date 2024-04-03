class StoreSimCardModel {
  late String simCardNo1;
  late String simCardNo2;

  StoreSimCardModel({required this.simCardNo1, required this.simCardNo2});

  factory StoreSimCardModel.fromJson(Map<String, dynamic> json) =>
      StoreSimCardModel(
          simCardNo1: json['simCardNo1'], simCardNo2: json['simCardNo2']);

  Map<String, dynamic> toJson() =>
      {'simCardNo1': simCardNo1, 'simCardNo2': simCardNo2};

  static List<Map<String, dynamic>> toJsonList(List<StoreSimCardModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
