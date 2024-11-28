import 'package:rent2ownwelcomeapp/models/tiktokVideoResponse.dart';

class StoreTiktokModel {
  late String userID;
  late String userName;
  late String imageUrl;
  late List<TiktokVideoModel> videos;

  StoreTiktokModel(
      {required this.userID,
      required this.userName,
      required this.imageUrl,
      required this.videos});

  factory StoreTiktokModel.fromJson(Map<String, dynamic> json) =>
      StoreTiktokModel(
          userID: json['userID'],
          userName: json['userName'],
          imageUrl: json['imageUrl'],
          videos: json['videos']);

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'userName': userName,
        'imageUrl': imageUrl,
        'videos': videos
      };
}
