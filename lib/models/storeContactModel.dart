class StoreContactModel {
  late String displayName;
  late String firstName;
  late String lastName;
  late String phoneNo;
  late String email;

  StoreContactModel(
      {required this.displayName,
      required this.firstName,
      required this.lastName,
      required this.phoneNo,
      required this.email});

  factory StoreContactModel.fromJson(Map<String, dynamic> json) =>
      StoreContactModel(
          displayName: json['displayName'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          phoneNo: json['phoneNo'],
          email: json['email']);

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNo': phoneNo,
        'email': email
      };

  static List<Map<String, dynamic>> toJsonList(List<StoreContactModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
