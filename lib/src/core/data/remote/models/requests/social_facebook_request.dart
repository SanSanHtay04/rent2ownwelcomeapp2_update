import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_facebook_request.freezed.dart';
part 'social_facebook_request.g.dart';

@freezed
class SocialFacebookRequest with _$SocialFacebookRequest {
  const SocialFacebookRequest._();

  const factory SocialFacebookRequest({
    required  String userID,
    required String userName,
    required String imageUrl,
    required String phoneNo,
    required String email,
    
  }) = _SocialFacebookRequest;

  factory SocialFacebookRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialFacebookRequestFromJson(json);
}

/*
{
        'userID': userID,
        'userName': userName,
        'imageUrl': imageUrl,
        'email': email,
        'phoneNo': phoneNo
      };
*/