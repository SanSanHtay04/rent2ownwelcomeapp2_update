import 'dart:io';

import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {

  // STEP1
  Future<bool> requestDevicePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.contacts,
      Permission.phone,
    ].request();

    bool isAccessible = statuses.values.every(  (element )=> element.isGranted);

    (!isAccessible)? await openAppSettings(): null;
    return isAccessible;

  }

  // STEP2
  Future<bool> requestLocationPermission() async{
    PermissionStatus permission = await Permission.location.status;

    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus.isGranted;
    } else {
      return permission.isGranted;
    }

  }

  

   Future<void> requestPhoneNumberPermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    bool permission = await MobileNumber.hasPhonePermission;
    if (!permission) {
      await MobileNumber.requestPhonePermission;
      if (!await MobileNumber.hasPhonePermission) {
        await onNotGranted();
        requestPhoneNumberPermission(
            onGranted: onGranted, onNotGranted: onNotGranted);
      } else {
        onGranted();
      }
    } else {
      onGranted();
    }
  }

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
