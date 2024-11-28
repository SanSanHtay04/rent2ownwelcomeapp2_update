import 'package:rent2ownwelcomeapp/models/tiktokUserInfoResponse.dart';

class TiktokVideoResponse {
  late TiktokErrorModel error;
  late List<TiktokVideoModel> videos;

  TiktokVideoResponse(json) {
    error = TiktokErrorModel(json['error']);

    List<TiktokVideoModel> temp = [];
    for (int i = 0; i < json['data']['videos'].length; i++) {
      TiktokVideoModel video = TiktokVideoModel(json['data']['videos'][i]);
      temp.add(video);
    }
    videos = temp;
  }
}

class TiktokVideoModel {
  late String title;
  late String videoDescription;
  late String coverImageUrl;
  late int duration;
  late String embedLink;
  late String id;
  late String shareUrl;

  TiktokVideoModel(json) {
    title = json['title'];
    videoDescription = json['video_description'];
    coverImageUrl = json['cover_image_url'];
    duration = json['duration'];
    embedLink = json['embed_link'];
    id = json['id'];
    shareUrl = json['share_url'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'video_description': videoDescription,
        'cover_image_url': coverImageUrl,
        'duration': duration,
        'embed_link': embedLink,
        'id': id,
        'share_url': shareUrl
      };

  static List<Map<String, dynamic>> toJsonList(List<TiktokVideoModel> list) =>
      list.map((e) => e.toJson()).toList();
}
