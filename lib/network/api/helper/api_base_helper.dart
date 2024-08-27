import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart';
import 'package:rent2ownwelcomeapp/models/tiktokUserInfoResponse.dart';
import 'package:rent2ownwelcomeapp/models/tiktokVideoResponse.dart';
import 'package:rent2ownwelcomeapp/network/api/api_constant.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/tiktokTokenResponse.dart';

class ApiBaseHelper {
  final String _baseUrl = baseUrl;
  Client client = Client();

  Future<dynamic> post(String url, dynamic bodyData) async {
    String deviceID = await getDeviceIdAndInfo();
    String accessToken = await getAccessTokenDataFromSharedPreference();
    String lang = await getLanguage();

    AppLogger.i("BASEURL => $_baseUrl $lang");

    AppLogger.i('POST => $url , DevID => $deviceID');
    final response = await client.post(Uri.parse(_baseUrl + url),
        headers: {
          "Cache-Control": "no-cache",
          "Content-Type": "application/json",
          "x-device-id": deviceID,
          "access-token": accessToken,
          "language": lang
        },
        body: bodyData);

    return response;
  }

  Future<dynamic> postFD(String url, dynamic bodyData) async {
    String deviceID = await getDeviceIdAndInfo();
    String accessToken = await getAccessTokenDataFromSharedPreference();
    String lang = await getLanguage();

    AppLogger.i("BASEURL => $_baseUrl");

    AppLogger.i('POST => $url , DevID => $deviceID');
    final response = await client.post(Uri.parse(_baseUrl + url),
        headers: {
          "Cache-Control": "no-cache",
          "Content-Type": "application/x-www-form-urlencoded",
          "x-device-id": deviceID,
          "access-token": accessToken,
          "language": lang
        },
        body: bodyData);
    // .interceptWithChuck(chuck, body: bodyData);

    AppLogger.i("HEA => ${response.headers}");

    return response;
  }

  Future<String> getAccessTokenDataFromSharedPreference() async {
    SharedPreferences spf = await SharedPreferences.getInstance();

    return spf.getString(ACCESS_TOKEN) ?? "";
  }

  Future<String> getLanguage() async {
    final FlutterLocalization _localization = FlutterLocalization.instance;
    String lang =
        _localization.currentLocale.toString().contains("en") ? "en" : "my";
    return lang;
  }

  Future<String> getDeviceIdAndInfo() async {
    late String deviceid;
    String deviceName = "";
    String deviceVersion;
    String identifier;
    String model = "";

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.brand!;
        deviceVersion = build.version.toString();
        identifier = build.id!;
        deviceid = build.id.toString();
        model = build.model.toString();
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name!;
        deviceVersion = data.systemVersion!;
        identifier = data.identifierForVendor!;
        deviceid = data.identifierForVendor.toString();
        model = data.model.toString();
      }
    } on PlatformException {}

    String deviceInfo = "$deviceid,$deviceName,$model";

    return deviceInfo;
  }

  //TIKTOK
  //Get Access Token
  Future<TiktokTokenResponse> getTiktokAccessToken(
      String url, String authCode) async {
    late TiktokTokenResponse response;

    final dio = Dio();
    final res = dio.post(
      url,
      data: {
        "client_key": ttClientKey,
        "client_secret": ttClientSecret,
        "code": authCode,
        "grant_type": ttGrantType,
        "redirect_uri": ttRedirectUrl
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    await res.then((resp) {
      response = TiktokTokenResponse(resp.data);

      AppLogger.i("RESP => ${response.accessToken}");
    });

    AppLogger.i("HEA => ${json.encode(res.toString())}");

    return response;
  }

  //Get User Info
  Future<TiktokUserInfoResponse> getTiktokUserInfo(
      String url, String accessToken) async {
    late TiktokUserInfoResponse response;

    final dio = Dio();
    final res = dio.get(
      url,
      options: Options(headers: {
        "Cache-Control": "no-cache",
        "Authorization": "Bearer $accessToken",
      }),
    );

    await res.then((resp) {
      response = TiktokUserInfoResponse(resp.data);
    });

    return response;
  }

  //Get VideoList
  Future<TiktokVideoResponse> getTiktokVideoList(
      String url, String accessToken) async {
    late TiktokVideoResponse response;

    final dio = Dio();
    final res = dio.post(
      url,
      options: Options(headers: {
        "Cache-Control": "no-cache",
        "Authorization": "Bearer $accessToken",
      }),
    );

    await res.then((resp) {
      response = TiktokVideoResponse(resp.data);
      AppLogger.i("VL RESP => ${response.error.code}");
    });

    return response;
  }

  //For V2
  Future<dynamic> get(String url) async {
    String deviceID = await getDeviceIdAndInfo();
    String accessToken = await getAccessTokenDataFromSharedPreference();
    String lang = await getLanguage();

    AppLogger.i("BASEURL => ${_baseUrl + url}");
    AppLogger.i("AT => $accessToken");
    AppLogger.i("LANG => ${lang}");

    final response = await client.get(
      Uri.parse(_baseUrl + url),
      headers: {
        "Cache-Control": "no-cache",
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "x-device-id": deviceID,
        "access-token": accessToken,
        "language": lang
      },
    );

    AppLogger.i("RES => ${json.encode(response.body)}");

    return response;
  }
}
