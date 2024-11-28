import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
  Future<bool> requestLocationsPermission() async{
    PermissionStatus permission = await Permission.location.status;

    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus.isGranted;
    } else {
      return permission.isGranted;
    }

  }



  Future<void> requestLocationPermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    var permission = await Permission.location.status;
    if (!permission.isGranted) {
      permission = await Permission.location.request();
      if (!permission.isGranted) {
        await onNotGranted();

      } else {
        onGranted();
      }
    } else {
      onGranted();
    }
  }

  Future<void> requestContactsPermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    var permission = await Permission.contacts.status;
    if (!permission.isGranted) {
      permission = await Permission.contacts.request();
      if (!permission.isGranted) {
        await onNotGranted();
        await requestContactsPermission(
            onGranted: onGranted, onNotGranted: onNotGranted);
      } else {
        onGranted();
      }
    } else {
      onGranted();
    }
  }

  Future<void> requestPhonePermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    var permission = await Permission.phone.status;
    if (!permission.isGranted) {
      permission = await Permission.phone.request();
      if (!permission.isGranted) {
        await onNotGranted();
        await requestPhonePermission(
            onGranted: onGranted, onNotGranted: onNotGranted);
      } else {
        onGranted();
      }
    } else {
      onGranted();
    }
  }

  Future<void> requestSMSPermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    var permission = await Permission.sms.status;
    if (!permission.isGranted) {
      permission = await Permission.sms.request();
      if (!permission.isGranted) {
        await onNotGranted();
        await requestSMSPermission(
            onGranted: onGranted, onNotGranted: onNotGranted);
      } else {
        onGranted();
      }
    } else {
      onGranted();
    }
  }

  Future<void> requestStoragePermission({
    required Function() onGranted,
    required Future Function() onNotGranted,
  }) async {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final int androidVersion = int.parse(androidInfo.version.release);

    bool havePermission = false;
    if (androidVersion >= 13) {
      final request = await [
        //Permission.videos,
        Permission.photos,
        //..... as needed
      ].request();

      havePermission =
          request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      onNotGranted();
      // await requestStoragePermission(onGranted: onGranted, onNotGranted: onNotGranted);
    } else {
      onGranted();
    }
  }
}
