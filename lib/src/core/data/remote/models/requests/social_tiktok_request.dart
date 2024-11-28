import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_tiktok_request.freezed.dart';
part 'social_tiktok_request.g.dart';

@freezed
class SocialTiktokRequest with _$SocialTiktokRequest {
  const SocialTiktokRequest._();

  const factory SocialTiktokRequest({
    required String userID,
    required String userName,
    required String imageUrl,
    @Default([]) List<TiktokVideoData> videos,
  }) = _SocialTiktokRequest;

  factory SocialTiktokRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialTiktokRequestFromJson(json);
}

/*
{
        'userID': userID,
        'userName': userName,
        'imageUrl': imageUrl,
        'videos': videos
      };
*/

@freezed
class TiktokVideoData with _$TiktokVideoData {
  const TiktokVideoData._();

  const factory TiktokVideoData({
    required String id,
    required String title,
    required int duration,
    @JsonKey(name: 'video_description') required String description,
    @JsonKey(name: 'cover_image_url') required String imageUrl,
    @JsonKey(name: 'share_url') required String sharedUrl,
    @JsonKey(name: 'embed_link') required String embeddedLink,
  }) = _TiktokVideoData;

  factory TiktokVideoData.fromJson(Map<String, dynamic> json) =>
      _$TiktokVideoDataFromJson(json);
}
/*
{
   late String title;
  late String videoDescription;
  late String coverImageUrl;
  late int duration;
  late String embedLink;
  late String id;
  late String shareUrl;

        'title': title,
        'video_description': videoDescription,
        'cover_image_url': coverImageUrl,
        'duration': duration,
        'embed_link': embedLink,
        'id': id,
        'share_url': shareUrl
      };
*/
