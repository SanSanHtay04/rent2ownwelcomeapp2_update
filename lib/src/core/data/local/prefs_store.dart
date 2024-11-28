import 'dart:convert';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

// welcome app data
const String ACCOUNT_INFO_KEY = "account_info";
const String DEVICE_ID = "device_id";
const String ANDROID_ID = "android_id";
const String LAGUAGE_CODE = 'language_code';
const String FIRST_INSTALLATION = 'first_installation';
const String THEME_MODE = "theme_mode";

//languages code
const String ENGLISH = 'en';
const String BURMESE = 'my';

class PrefsStore {
  late SharedPreferences _preferences;
  PrefsStore(SharedPreferences sharedPreferences) {
    _preferences = sharedPreferences;
  }

  setDeviceId(String data) {
    _preferences.setString(DEVICE_ID, data);
  }

  String? get deviceId {
    var data = _preferences.getString(DEVICE_ID);
    return data ?? "Empty DeviceID";
  }

  setAndroidId(String data) {
    _preferences.setString(ANDROID_ID, data);
  }

  String? get androidId {
    var data = _preferences.getString(ANDROID_ID);
    return data ?? "Empty Android Id";
  }

  setAccountInfo(VerifyOtpResponse authResponse) {
    _preferences.setString(ACCOUNT_INFO_KEY, json.encode(authResponse));
  }

  VerifyOtpResponse? get accountInfo {
    var data = _preferences.getString(ACCOUNT_INFO_KEY);
    if (data == null) {
      return null;
    }
    var map = json.decode(data);
    return map == null ? null : VerifyOtpResponse.fromJson(map);
  }

  String? get accessToken => accountInfo?.accessToken;
  num? get expiredTime => accountInfo?.expiration;

  Future<void> clearAccountInfo() => _preferences.remove(ACCOUNT_INFO_KEY);

  setThemeMode(String themeMode) {
    _preferences.setString(THEME_MODE, themeMode);
  }

  String? getThemeMode() {
    return _preferences.getString(THEME_MODE);
  }

  setLanguage(String languageCode) {
    _preferences.setString(LAGUAGE_CODE, languageCode);
  }

  String? getLanguage() {
    return _preferences.getString(LAGUAGE_CODE);
  }

  Locale getLocale(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return const Locale(ENGLISH, 'US');
      case BURMESE:
        return const Locale(BURMESE, "MY");
      default:
        return const Locale(ENGLISH, 'US');
    }
  }

  setFirstInstallation(bool isInstalled) {
    _preferences.setBool(FIRST_INSTALLATION, isInstalled);
  }

  bool? getFirstInstallation() {
    return _preferences.getBool(FIRST_INSTALLATION);
  }
}
