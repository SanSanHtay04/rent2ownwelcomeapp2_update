import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/shared/app_device_info.dart';

class AppRepository with BaseRepository {
  late PrefsStore _prefsStore;

  AppRepository({ required PrefsStore prefsStore}){

   _prefsStore = prefsStore;

  }

  Future<String> deviceId() async {
    return (_prefsStore.deviceId) ?? "Empty DeviceID";
  }

  Future<void> updateDeviceId() async {
    final data = await AppDeviceInfo().getImei();
    await _prefsStore.setDeviceId(data);
  }

  Future<ThemeMode> themeMode() async {
    final indexString = await _prefsStore.getThemeMode();
    final index = int.tryParse(indexString ?? '') ?? 1;
    return ThemeMode.values[index];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    _prefsStore.setThemeMode(theme.index.toString());

    // await _storage.write(key: 'theme_mode', value: theme.index.toString());
  }

  Future<String> languageCode() async {
    return (await _prefsStore.getLocale()) ?? Intl.getCurrentLocale();
  }

  Future<void> updateLanguage(String language) async {
    _prefsStore.setLocale(language);

    // await _storage.write(key: 'language', value: language);
  }
}
