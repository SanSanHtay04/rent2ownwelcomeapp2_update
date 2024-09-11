export 'string.dart';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

extension ContextX on BuildContext {
  MediaQueryData getMediaQuery() => MediaQuery.of(this);

  Size getScreenSize() => getMediaQuery().size;

  Orientation getOrientation() => getMediaQuery().orientation;

  ThemeData getTheme() => Theme.of(this);

  ColorScheme getColorScheme() => getTheme().colorScheme;

  TextTheme getTextTheme() => getTheme().textTheme;
}

Future<String> getVersionInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;

  AppLogger.i('Welcome Version: $version');
  return version;
}
