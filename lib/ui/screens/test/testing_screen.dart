import 'dart:async';
import 'dart:io';

import 'package:app_usage/app_usage.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usage_stats/usage_stats.dart';

class TestingScreen extends StatefulWidget {
  TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  late String deviceid;
  late String deviceType;
  late String brand;
  late String operationSystemVersion;
  late String deviceName;
  late String identifier;
  late int totalAppInstalled;

  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();

  //app usage
  List<AppUsageInfo> _infos = [];

  /**
   * Battery
   */
  final Battery _battery = Battery();
  late String batteryLevel;
  late String batteryStateStr;
  // created a Batterystate of enum type
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    getUsageStats();
    getDeviceIdAndInfo();

    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);
    getBatteryInfo();
    super.initState();

    initUsage();
  }

  Future<void> initUsage() async {
    try {
      UsageStats.grantUsagePermission();

      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));

      List<EventUsageInfo> queryEvents =
          await UsageStats.queryEvents(startDate, endDate);
      List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(
        startDate,
        endDate,
        networkType: NetworkType.all,
      );

      Map<String?, NetworkInfo?> netInfoMap = Map.fromIterable(networkInfos,
          key: (v) => v.packageName, value: (v) => v);

      List<UsageInfo> t = await UsageStats.queryUsageStats(startDate, endDate);

      for (var i in t) {
        if (double.parse(i.totalTimeInForeground!) > 0) {
          print(
              DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!))
                  .toIso8601String());

          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!))
              .toIso8601String());

          print(i.packageName);
          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeUsed!))
              .toIso8601String());
          print(int.parse(i.totalTimeInForeground!) / 1000 / 60);

          print('-----\n');
        }
      }

      this.setState(() {
        events = queryEvents.reversed.toList();
        _netInfoMap = netInfoMap;
      });
    } catch (err) {
      print(err);
    }
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 30));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      setState(() => _infos = infoList);

      for (var info in infoList) {
        print("TT" + info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  void getBatteryInfo() async {
    final level = await _battery.batteryLevel;
    batteryLevel = "$level %";

    if (_batteryState == BatteryState.charging) {
      batteryStateStr = "Charging";
    } else if (_batteryState == BatteryState.full) {
      batteryStateStr = "Full";
    } else if (_batteryState == BatteryState.discharging) {
      batteryStateStr = "Discharging";
    } else {
      batteryStateStr = "EE";
    }
  }

  void getDeviceIdAndInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceType = "Android";
        brand = build.brand;
        var sdkInt = build.version.sdkInt;
        operationSystemVersion =
            "Android ${build.version.release} (SDK $sdkInt), ${build.manufacturer} ${build.model}";
        deviceName = build.model;
        identifier = build.id;
        deviceid = build.id.toString();
        print(
            "OPT =>  $brand $deviceType ${build.manufacturer} ${build.model} $identifier");
      } else if (Platform.isIOS) {
        deviceType = "iOS";
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        operationSystemVersion =
            "${data.systemName} ${data.systemVersion}, ${data.name} ${data.model}";
        identifier = data.identifierForVendor!;
        deviceid = data.identifierForVendor.toString();
      }
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Container(
    //       child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       const Text(
    //         "Device Info",
    //         style: TextStyle(
    //             color: Colors.black,
    //             fontStyle: FontStyle.italic,
    //             fontWeight: FontWeight.w600),
    //       ),
    //       Text("Device Type  => $deviceType"),
    //       Text("Device Brand => $brand"),
    //       Text("OS Version   => $operationSystemVersion"),
    //       Text("Device ID    => $deviceid"),
    //       Text("Battery Level => $batteryLevel"),
    //       Text("Battery State => $batteryStateStr"),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       const Text("App Installed",
    //           style: TextStyle(
    //               color: Colors.black,
    //               fontStyle: FontStyle.italic,
    //               fontWeight: FontWeight.w600)),
    //       Expanded(
    //           child: ListView.builder(
    //               itemCount: _infos.length,
    //               itemBuilder: (context, index) {
    //                 return ListTile(
    //                   title: Text(_infos[index].appName),
    //                   subtitle: Text(
    //                       "${_infos[index].usage} \n[${_infos[index].startDate},${_infos[index].endDate}] \nUsage => ${_infos[index].usage.inMinutes} mins "),
    //                 );
    //               }))

    //       /* Expanded(
    //           child: FutureBuilder<List<AppInfo>>(
    //         future: InstalledApps.getInstalledApps(true, true),
    //         builder: (BuildContext buildContext,
    //             AsyncSnapshot<List<AppInfo>> snapshot) {
    //           totalAppInstalled = snapshot.data!.length;
    //           return snapshot.connectionState == ConnectionState.done
    //               ? snapshot.hasData
    //                   ? ListView.builder(
    //                       shrinkWrap: false,
    //                       itemCount: snapshot.data!.length + 1,
    //                       itemBuilder: (context, index) {
    //                         // AppInfo app = snapshot.data![index];

    //                         return index == 0
    //                             ? Text(
    //                                 "Total App Installed => $totalAppInstalled")
    //                             : Card(
    //                                 child: ListTile(
    //                                   title: Text(
    //                                       "${snapshot.data![index - 1].name} ${snapshot.data![index - 1].packageName}"),
    //                                   subtitle: Text(snapshot.data![index - 1]
    //                                       .getVersionInfo()),
    //                                 ),
    //                               );
    //                       },
    //                     )
    //                   : Center(
    //                       child: Text(
    //                           "Error occurred while getting installed apps ...."))
    //               : Center(child: Text("Getting installed apps ...."));
    //         },
    //       ))*/
    //     ],
    //   )),
    // );

    return Scaffold(
      appBar: AppBar(title: const Text("Usage Stats"), actions: [
        IconButton(
          onPressed: UsageStats.grantUsagePermission,
          icon: Icon(Icons.settings),
        )
      ]),
      body: Container(
        child: RefreshIndicator(
          onRefresh: initUsage,
          child: ListView.separated(
            itemBuilder: (context, index) {
              var event = events[index];
              var networkInfo = _netInfoMap[event.packageName];
              return ListTile(
                title: Text(events[index].packageName!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                    networkInfo == null
                        ? Text("Unknown network usage")
                        : Text("Received bytes: ${networkInfo.rxTotalBytes}\n" +
                            "Transfered bytes : ${networkInfo.txTotalBytes}"),
                  ],
                ),
                trailing: Text(events[index].eventType!),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: events.length,
          ),
        ),
      ),
    );
  }
}
