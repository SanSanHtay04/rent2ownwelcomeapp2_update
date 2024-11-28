class StoreLocationModel {
  late String latitude;
  late String longitude;

  StoreLocationModel({required this.latitude, required this.longitude});

  factory StoreLocationModel.fromJson(Map<String, dynamic> json) =>
      StoreLocationModel(
          latitude: json['latitude'], longitude: json['longitude']);

  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};

  static List<Map<String, dynamic>> toJsonList(List<StoreLocationModel> list) =>
      list.map((e) => e.toJson()).toList();
}
