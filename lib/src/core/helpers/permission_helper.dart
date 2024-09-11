import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static void requestContactPermission() async {
    Map<Permission, PermissionStatus> statuses = (Platform.isIOS)
        ? await [Permission.contacts].request()
        : await [
            Permission.sms,
            Permission.contacts,
            Permission.phone,
          ].request();

    statuses.values.every((e) => !e.isGranted) ? await openAppSettings() : null;
  }

  // static void requestPermission({
  //   required Function() onGranted,
  //   required Future Function() onNotGranted,
  // }) async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission != LocationPermission.always) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.always) {
  //       await onNotGranted();
  //       requestPermission(onGranted: onGranted, onNotGranted: onNotGranted);
  //     } else {
  //       onGranted();
  //     }
  //   } else {
  //     onGranted();
  //   }
  // }
}
