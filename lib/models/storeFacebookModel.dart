class StoreFacebookModel {
  late String userID;
  late String userName;
  late String imageUrl;
  late String email;
  late String phoneNo;

  StoreFacebookModel(
      {required this.userID,
      required this.userName,
      required this.imageUrl,
      required this.email,
      required this.phoneNo});

  factory StoreFacebookModel.fromJson(Map<String, dynamic> json) =>
      StoreFacebookModel(
          userID: json['userID'],
          userName: json['userName'],
          imageUrl: json['imageUrl'],
          email: json['email'],
          phoneNo: json['phoneNo']);

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'userName': userName,
        'imageUrl': imageUrl,
        'email': email,
        'phoneNo': phoneNo
      };

  static List<Map<String, dynamic>> toJsonList(List<StoreFacebookModel> list) =>
      list.map((e) => e.toJson()).toList();
}
