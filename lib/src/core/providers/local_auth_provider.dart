import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class LocalAuthProvider with ChangeNotifier {
  final PrefsStore _prefsStore;
  late bool isLoggedIn;

  LocalAuthProvider(this._prefsStore) {
    isLoggedIn = !_prefsStore.accessToken.isNullOrEmpty;
  }

  Future<void> logout() async {
    await _prefsStore.clearAccountInfo();
    isLoggedIn = false;
    notifyListeners();
  }

  String? get deviceId => _prefsStore.deviceId;
  String? get accessToken => _prefsStore.accessToken;

  String? get androidId => _prefsStore.androidId;
}
