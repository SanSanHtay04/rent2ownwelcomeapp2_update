import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:logger/logger.dart';
import 'package:rent2ownwelcomeapp/models/api_response.dart';
import 'package:rent2ownwelcomeapp/models/storeFacebookModel.dart';
import 'package:rent2ownwelcomeapp/models/storeTiktokModel.dart';
import 'package:rent2ownwelcomeapp/models/tiktokTokenResponse.dart';
import 'package:rent2ownwelcomeapp/models/tiktokUserInfoResponse.dart';
import 'package:rent2ownwelcomeapp/models/tiktokVideoResponse.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';

class TiktokBloc {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  //Get auth code
  getToken({required authCode}) async {
    var res = await _apiBaseHelper.getTiktokAccessToken(
        getTokenApiEndpoint, authCode);

    TiktokTokenResponse response = res;
    logger.i("RESP => ${response.accessToken}");

    getUserInfo(accessToken: response.accessToken);
    getVideoList(accessToken: response.accessToken);
  }

  //Get user info
  late TiktokUserInfoModel userInfo;

  getUserInfo({required accessToken}) async {
    var res = await _apiBaseHelper.getTiktokUserInfo(
        getUserInfoEndpoint, accessToken);

    if (res.errorModel.code.toLowerCase() == "ok") {
      userInfo = res.userInfo;
    }
  }

  //Get video list
  List<TiktokVideoModel> videos = [];

  getVideoList({required accessToken}) async {
    var res = await _apiBaseHelper.getTiktokVideoList(
        getVideoListEndpoint, accessToken);

    if (res.error.code.toLowerCase() == "ok") {
      videos = res.videos;

      storeTiktokInfo(userInfo, videos);
    }
  }

  final StreamController<ApiResponse> _storeTiktokInfoConrtoller =
      StreamController.broadcast();

  Stream<ApiResponse> getStoreTikTokInfoStream() =>
      _storeTiktokInfoConrtoller.stream;

  storeTiktokInfo(
      TiktokUserInfoModel userInfoModel, List<TiktokVideoModel> videos) async {
    StoreTiktokModel storeTiktokModel = StoreTiktokModel(
        userID: userInfo.unionId,
        userName: userInfo.displayName,
        imageUrl: userInfo.avatarUrl,
        videos: videos);

    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    responseOb.data = storeTiktokModel;
    responseOb.msgState = MsgState.data;
    _storeTiktokInfoConrtoller.sink.add(responseOb);

    //print(json.encode(storeTiktokModel));
  }

  //get facebook profile info
  final StreamController<ApiResponse> _storeFBProfileInfoController =
      StreamController.broadcast();

  Stream<ApiResponse> getStoreFBProfileInfoStream() =>
      _storeFBProfileInfoController.stream;
  late AccessToken? _accessToken;

  storeFBProfileInfo() async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email, user_link',
        'user_friends',
      ], //'user_link''user_location', 'user_likes','user_photos',
    );

    if (result.status == LoginStatus.success) {
      final fbInstance = FacebookAuth.instance;
      _accessToken = await FacebookAuth.instance.accessToken;

      await fbInstance
          .getUserData(fields: "id,name,email,picture,friends,link")
          .then((value) {
        if (value == null) {
          // print("FB ERR => null");
        } else {

          // print("Value => ${value.entries.toString()}");
          final profile = json.decode(value.entries.toString());

          // logger.e("PP => ${json.encode(profile)}"); "friends":{"data":[],"summary":{"total_count":0}}
          String type = "facebook";
          String loginIds = profile['id']; //_accessToken.userId.toString();
          String name = profile['name'];
          String email = profile['email'] ?? "";
          String phone = "";
          String image = profile['picture']['data']['url'];


          // print(
          //  "AccTok => ${_accessToken!.token}  LIDS => $loginIds Email => $email , Name => $name , Img => $image , phoneNo: $phone");


          StoreFacebookModel storeFB = StoreFacebookModel(
              userID: loginIds,
              userName: name,
              imageUrl: image,
              email: email,
              phoneNo: phone);

          responseOb.data = storeFB;
          responseOb.msgState = MsgState.data;
          _storeFBProfileInfoController.sink.add(responseOb);
        }
      }).onError((error, stackTrace) {
          responseOb.data = null;
          responseOb.msgState = MsgState.error;
          responseOb.errorState = ErrorState.unknownErr;
          _storeFBProfileInfoController.sink.add(responseOb);
        }).catchError((e) {
          responseOb.data = null;
          responseOb.msgState = MsgState.error;
          responseOb.errorState = ErrorState.unknownErr;
          _storeFBProfileInfoController.sink.add(responseOb);
        });

      // final graphResponse = await http
      //     .get(Uri.parse(
      //         'https://graph.facebook.com/"iii"?fields=id,name,email,picture,friends,link&access_token=${_accessToken!.token}'
      //         //'https://graph.facebook.com/$loginId?fields=id,name,email,picture,link&access_token=${_accessToken!.token}' //for user_link
      //         ))
      //     .then((value) {
      //   if (value == null) {
      //     // print("FB ERR => null");
      //   } else {
      //     // print("Value => ${value.body.toString()}");
      //     final profile = json.decode(value.body);
      //
      //     // logger.e("PP => ${json.encode(profile)}"); "friends":{"data":[],"summary":{"total_count":0}}
      //
      //     String type = "facebook";
      //     String loginIds = profile['id']; //_accessToken.userId.toString();
      //     String name = profile['name'];
      //     String email = profile['email'] ?? "";
      //     String phone = "";
      //     String image = profile['picture']['data']['url'];
      //
      //     // print(
      //     //     "AccTok => ${_accessToken!.token}  LIDS => $loginIds Email => $email , Name => $name , Img => $image , phoneNo: $phone");
      //
      //     StoreFacebookModel storeFB = StoreFacebookModel(
      //         userID: loginIds,
      //         userName: name,
      //         imageUrl: image,
      //         email: email,
      //         phoneNo: phone);
      //
      //     responseOb.data = storeFB;
      //     responseOb.msgState = MsgState.data;
      //     _storeFBProfileInfoController.sink.add(responseOb);
      //   }
      // }).onError((error, stackTrace) {
      //   responseOb.data = null;
      //   responseOb.msgState = MsgState.error;
      //   responseOb.errorState = ErrorState.unknownErr;
      //   _storeFBProfileInfoController.sink.add(responseOb);
      // }).catchError((e) {
      //   responseOb.data = null;
      //   responseOb.msgState = MsgState.error;
      //   responseOb.errorState = ErrorState.unknownErr;
      //   _storeFBProfileInfoController.sink.add(responseOb);
      // });
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;
      _storeFBProfileInfoController.sink.add(responseOb);

    }
  }
}
