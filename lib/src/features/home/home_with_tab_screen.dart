import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_usage/app_usage.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:call_log/call_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rent2ownwelcomeapp/models/appUsagePatternModel.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';
import 'package:rent2ownwelcomeapp/models/callFrequencyModel.dart';
import 'package:rent2ownwelcomeapp/models/deviceInfoModel.dart';
import 'package:rent2ownwelcomeapp/models/downloadHistoryModel.dart';
import 'package:rent2ownwelcomeapp/models/textMessageFrequencyModel.dart';
import 'package:rent2ownwelcomeapp/src/features/home/homeBloc.dart';
import 'package:rent2ownwelcomeapp/src/features/status/status_tab_screen.dart';
import 'package:rent2ownwelcomeapp/src/features/toreview/to_review_tab_screen.dart';
import 'package:rent2ownwelcomeapp/src/features/tosubmit/submitted_success_tab_screen.dart';
import 'package:rent2ownwelcomeapp/src/features/tosubmit/to_submit_tab_screen.dart';
import 'package:rent2ownwelcomeapp/src/core/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../../models/api_response.dart';
import '../../../models/storeCallLogModel.dart';
import '../../../models/storeContactModel.dart';
import '../../../models/storeFacebookModel.dart';
import '../../../models/storeLocationModel.dart';
import '../../../models/storeSMSLogModel.dart';
import '../../../models/store_sim_card_model.dart';
import '../../../models/storeTiktokModel.dart';
import '../../../network/api/api_constant.dart';
import '../../core/helpers/app_logger.dart';

class HomeWithTabScreen extends StatefulWidget {
  final bool isAldLogin;
  final List<StoreSimCardModel>? storeSims;
  final List<StoreContactModel>? storeContacts;
  final List<StoreCallLogModel>? storeCallLogs;
  final List<StoreSMSLogModel>? storeSMSs;
  final List<StoreLocationModel>? storeLocations;
  final StoreFacebookModel? storeFacebooks;
  final StoreTiktokModel? storeTiktokInfo;
  const HomeWithTabScreen({
    super.key,
    this.isAldLogin = false,
    this.storeSims,
    this.storeContacts,
    this.storeCallLogs,
    this.storeSMSs,
    this.storeLocations,
    this.storeFacebooks,
    this.storeTiktokInfo,
  });

  @override
  State<HomeWithTabScreen> createState() => _HomeWithTabScreenState();
}

class _HomeWithTabScreenState extends State<HomeWithTabScreen>
    with TickerProviderStateMixin {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  final HomeBolc _bloc = HomeBolc();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  TabController? _tabController;
  List<bool> _isDisabled = [false, true, true];
  late String _status; //  toSubmit, toReview, status

  //The children of the TabView
  var _tabViewChildren = const [
    ToSubmitTabView(),
    ToReviewTabView(),
    ToSubmitTabView(),
  ];

  //Device Info
  late String deviceid;
  late String deviceType;
  late String brand;
  late String operationSystemVersion;
  late String deviceName;
  late String identifier;
  int totalAppInstalled = 0;

  //app usage
  List<AppUsagePatternModel> _infos = [];

  //Battery
  final Battery _battery = Battery();
  late String batteryLevel;
  late String batteryStateStr;
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    //store extra Items

    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);

    //GET USER STATUS
    checkUserStatus();
    // getTextMessageFrequency();

    // getCallDurationNFrequency();

    //init the tab status
    _status = "APPLICANT_NOT_FOUND";

    super.initState();
  }

  restartScreen() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeWithTabScreen(
                  isAldLogin: true,
                )),
        (Route<dynamic> route) => false);
  }

  Future<void> _saveUserLoginData() async {
    SharedPreferences spfs = await SharedPreferences.getInstance();
    spfs.setBool(IS_ALD_LOGIN, true);
  }

  checkUserStatus() async {
    if (widget.isAldLogin) {
      getCurrentLocation(); //Update location

      //get application status
      _bloc.getApplicationStatus();
    } else {
      _saveUserLoginData();

      _bloc.storeSimCards(storeSimCards: widget.storeSims!);

      _bloc.storeContacts(
          storeSims: widget.storeSims!,
          storeContacts: widget.storeContacts!,
          storeSMSs: widget.storeSMSs!,
          storeCalls: widget.storeCallLogs!);

      _bloc.storeSMSLogs(
          storeSMSs: widget.storeSMSs!, storeCalls: widget.storeCallLogs!);

      _bloc.storeLocations(storeLocations: widget.storeLocations!);

      _bloc.storeCallLogs(storeCallLogs: widget.storeCallLogs!);

      //nid to check null or tt or fb for social media
      if (widget.storeFacebooks != null) {
        _bloc.storeFacebook(facebook: widget.storeFacebooks!);
      }
      if (widget.storeTiktokInfo != null) {
        _bloc.storeTiktokInfo(tiktokInfo: widget.storeTiktokInfo!);
      }

      //GET DOWNLOAD HISTORY
      if (Platform.isAndroid) {
        getInstalledApps();
      } else {
        getBatteryInfo();
      }

      //GET USAGE DATA
      getUsageStats();

      //GET CALL FREQUENCY
      getCallDurationNFrequency();

      //GET TEXT MESSAGE FREQUENCY
      getTextMessageFrequency();

      //get application status
      _bloc.getApplicationStatus();
    }
  }

  getCurrentLocation() async {
    await Permission.location.request();

    final position = await _geolocatorPlatform.getCurrentPosition();
    AppLogger.i("POSITION => ${position.latitude} , ${position.longitude}");

    List<StoreLocationModel> storeLocations = [];
    StoreLocationModel location = StoreLocationModel(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString());
    storeLocations.add(location);

    _bloc.storeLocations(storeLocations: storeLocations);
  }

  onTap() {
    if (_isDisabled[_tabController!.index]) {
      int index = _tabController!.previousIndex;
      setState(() {
        _tabController!.index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse>(
      stream: _bloc.getApplicationStatusStream(),
      initialData:
          ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr),
      builder: (context, snapshot) {
        ApiResponse resOb = snapshot.data!;

        if (resOb.msgState == MsgState.loading) {
          return mainLoading("");
        } else if (resOb.msgState == MsgState.data) {
          ApplicationStatusResponse statusResponse = resOb.data;

          checkStatus(statusResponse);

          return mainBuild();
        } else {
          String errMsg = "";

          if (resOb.errorState == ErrorState.serverErr) {
            errMsg = "500 Internal Server.";
          } else if (resOb.errorState == ErrorState.notFoundErr) {
            errMsg = "404 Not Found Error.";
          } else if (resOb.errorState == ErrorState.badRequest) {
            errMsg = "Bad Request Error.";
          } else if (resOb.errorState == ErrorState.forbiddenErr) {
            errMsg = "Unauthenticated";
          } else {
            errMsg = "Ooooops \n Something went wrong.";
          }

          return mainLoading(errMsg);
        }
      },
    );
  }

  checkStatus(ApplicationStatusResponse statusResponse) async {
    _status = statusResponse.status;

    if (_status == "APPLICANT_NOT_FOUND") {
      // print("NOAPP");
      _tabViewChildren = [
        ToSubmitTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [false, true, true];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 0);

      _tabController!.addListener(onTap);
    } else if (_status == "toSubmit") {
      // print("To submit");
      _tabViewChildren = [
        SubmittedSuccessfullyTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [false, true, true];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 0);

      _tabController!.addListener(onTap);
    } else if (_status == "toReview") {
      _tabViewChildren = [
        SubmittedSuccessfullyTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [true, false, true];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 1);

      _tabController!.addListener(onTap);
    } else if (_status == "performing") {
      _tabViewChildren = [
        SubmittedSuccessfullyTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [true, true, false];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 2);

      _tabController!.addListener(onTap);
    } else if (_status == "accepted" ||
        _status == "rejected" ||
        _status == "counterproposal") {
      _tabViewChildren = [
        SubmittedSuccessfullyTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [true, true, false];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 2);

      _tabController!.addListener(onTap);
    } else {
      //print("NOAPP");
      _tabViewChildren = [
        ToSubmitTabView(
          appStatusRes: statusResponse,
        ),
        ToReviewTabView(
          appStatusRes: statusResponse,
        ),
        StatusTabView(
          appstatus: statusResponse,
        )
      ];
      _isDisabled = [false, true, true];
      _tabController = TabController(
          length: _tabViewChildren.length, vsync: this, initialIndex: 0);

      _tabController!.addListener(onTap);
    }

    // mainBuild();
  }

  Widget mainBuild() {
    return WillPopScope(
        onWillPop: () => _onBackPressed(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: bgColor,
            centerTitle: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/home.png",
                      width: 180,
                    ),
                    TextButton.icon(
                        onPressed: () {
                          if (_localization.currentLocale
                              .toString()
                              .contains("en")) {
                            // print(
                            //     "LNEN => ${_localization.currentLocale.toString()}");
                            _localization.translate('my');
                          } else {
                            // print(
                            //     "LNMM => ${_localization.currentLocale.toString()}");
                            _localization.translate('en');
                          }

                          restartScreen();
                        },
                        icon: const Icon(
                          Icons.language,
                          color: bg1Color,
                        ),
                        label: Text(
                          _localization.getLanguageName(),
                          style: const TextStyle(color: bg1Color),
                        ))
                  ],
                ),
                const Center(
                  child: Text(
                    myApplication,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                        letterSpacing: -0.33),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            bottom: TabBar(
              isScrollable: false,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: toSubmit,
                ),
                Tab(
                  text: toReview,
                ),
                Tab(
                  text: status,
                )
              ],
              labelColor: bg1Color,
              unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.54),
              indicatorColor: bg1Color,
            ),
          ),
          body: Stack(
            children: [
              // implement the tab view
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: _tabViewChildren,
              ),
            ],
          ),
          // RefreshIndicator(
          //     onRefresh: () async {
          //       //get application status
          //       _bloc.getApplicationStatus();
          //       setState(() {});

          //       if (_status == "performing") {
          //         setState(() {});
          //         restartScreen();
          //       }

          //       Fluttertoast.showToast(
          //         msg: successfully_updated,
          //         toastLength: Toast.LENGTH_LONG,
          //         gravity: ToastGravity.CENTER,
          //         timeInSecForIosWeb: 1,
          //         backgroundColor: Colors.black,
          //         textColor: bg1Color,
          //         fontSize: 12.0,
          //       );
          //     },
          //     child: ListView(
          //       shrinkWrap: false,
          //       children: <Widget>[
          //         SizedBox(
          //             height: MediaQuery.of(context).size.height - 180,
          //             child: Stack(
          //               children: [
          //                 // implement the tab view
          //                 TabBarView(
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   controller: _tabController,
          //                   children: _tabViewChildren,
          //                 ),

          //                 //Container()
          //               ],
          //             ))
          //       ],
          //     )

          //     ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: bg1Color,
            onPressed: () {
              restartScreen();
            },
            child: const Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget mainLoading(errMsg) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: WillPopScope(
          onWillPop: () => _onBackPressed(),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 100,
                backgroundColor: bgColor,
                centerTitle: false,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/images/home.png",
                      width: 180,
                    ),
                    const Center(
                      child: Text(
                        myApplication,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black,
                            letterSpacing: -0.33),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                bottom: const TabBar(
                  isScrollable: false,
                  //controller: _tabController,
                  tabs: [
                    Tab(
                      text: toSubmit,
                    ),
                    Tab(
                      text: toReview,
                    ),
                    Tab(
                      text: status,
                    )
                  ],
                  labelColor: bg1Color,
                  unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.54),
                  indicatorColor: bg1Color,
                ),
              ),
              body: errMsg == ""
                  ? const Loading()
                  : RefreshIndicator(
                      onRefresh: () async {
                        //get application status
                        _bloc.getApplicationStatus();
                        setState(() {});
                        Fluttertoast.showToast(
                          msg: successfully_updated,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: bg1Color,
                          fontSize: 12.0,
                        );
                      },
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 180,
                            child: Center(
                                child: Text(
                              errMsg,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: errTxtColor),
                            )),
                          )
                        ],
                      ),
                      // Center(
                      //     child: Text(
                      //   errMsg,
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //       color: errTxtColor),
                      // )),
                    )),
        ));
  }

  _onBackPressed() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit an App?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              exit(0);
            },
            child: const Text('YES'),
          ),
        ],
      ),
    );
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
      setState(() {
        batteryStateStr = "Charging";
      });
    } else if (_batteryState == BatteryState.full) {
      setState(() {
        batteryStateStr = "Full";
      });
    } else if (_batteryState == BatteryState.discharging) {
      setState(() {
        batteryStateStr = "Discharging";
      });
    } else {
      setState(() {
        batteryStateStr = "EE";
      });
    }

    print("Battery => $batteryLevel $batteryStateStr");

    getDeviceIdAndInfo();
  }

  void getDeviceIdAndInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceType = "Android";
          brand = build.brand;
          var sdkInt = build.version.sdkInt;
          operationSystemVersion =
              "Android ${build.version.release} (SDK $sdkInt), ${build.manufacturer} ${build.model}";
          deviceName = build.model;
          identifier = build.id;
          deviceid = build.id.toString();
        });
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;

        setState(() {
          deviceType = "iOS";
          brand = data.utsname.machine;
          deviceName = data.name;
          operationSystemVersion =
              "${data.systemName} ${data.systemVersion}, ${data.name} ${data.model}";
          identifier = data.identifierForVendor!;
          deviceid = data.identifierForVendor.toString();
        });
      }
    } on PlatformException {}

    print(
        "Device Info => $deviceType # $operationSystemVersion # $deviceid # $brand");

    _storeExtraItems();
  }

  _storeExtraItems() async {
    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
        deviceType: deviceType,
        brand: brand,
        operationSystemVersion: operationSystemVersion,
        deviceId: deviceid,
        batteryState: batteryStateStr,
        batteryLevel: batteryLevel,
        noOfAppsInstalled: totalAppInstalled.toString());
    await _bloc.storeDeviceInfo(deviceInfo: deviceInfoModel);
  }

  void getUsageStats() async {
    // grant usage permission - opens Usage Settings
    UsageStats.grantUsagePermission();

    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 100));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      //setState(() => _infos = infoList);
      List<AppUsagePatternModel> _temp = [];

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
        _temp.add(AppUsagePatternModel(
            appName: appdetail,
            duration: usage,
            timeFrom: fromDate,
            timeTo: toDate));

        // print("US => $appdetail, $usage");
      }

      setState(() {
        _infos = _temp;
      });

      await _bloc.storeAppUsagePattern(storeAppUsagePattern: _infos);
    } on AppUsageException catch (exception) {
      //print(exception);
    }
  }

  getInstalledApps() async {
    //App Download history
    List<DownloadHistoryModel> storeDownloadHistory = [];
    List<DownloadHistoryModel> _temp = [];
    List<AppInfo> _installApps = await InstalledApps.getInstalledApps();
    for (AppInfo info in _installApps) {
      _temp.add(DownloadHistoryModel(
          packageName: info.packageName!,
          appName: info.name!,
          version: "${info.versionName}(${info.versionCode!})"));
      // print("V => ${info.name!} ${info.versionName}(${info.versionCode!})");
    }

    storeDownloadHistory = _temp;
    await _bloc.storeDownloadHistory(
        storeDownloadHistory: storeDownloadHistory);

    setState(() {
      totalAppInstalled = _installApps.length;
    });
    getBatteryInfo();
  }

  getCallDurationNFrequency() async {
    Iterable<CallLogEntry> callLogEntries = await CallLog.query();
    List<String> phoneNumbers = [];
    List<CallFrequencyModel> storeCalls = [];
    List<CallFrequencyModel> storeCallTemp = [];

    for (CallLogEntry entry in callLogEntries) {
      phoneNumbers.add(entry.number!);
    }

    phoneNumbers = phoneNumbers.toSet().toList();

    for (String phone in phoneNumbers) {
      storeCallTemp.add(CallFrequencyModel(
          phoneNo: phone,
          frequency: callLogEntries
              .where((e) => e.number == phone)
              .length
              .toString()));

      //         contactName: callLogEntries
      //         .where((e) => e.number == phone)
      //         .first
      //         .name
      //         .toString(),

      // print("Str => ${json.encode(storeCallTemp)}");

      // print("NAME =>" +
      //     callLogEntries.where((e) => e.number == phone).first.name.toString());
      // print(
      //     "$phone ${callLogEntries.where((e) => e.number == phone).length.toString()}"); // 2
    }

    storeCalls = storeCallTemp;

    _bloc.storeCallDurationNFrequency(storeCallFrequency: storeCalls);
  }

  getTextMessageFrequency() async {
    PermissionStatus permissionStatus = await _getSMSPermission();

    if (permissionStatus == PermissionStatus.granted) {
      List<TextMessageFrequencyModel> storeTxtMsgList = [];
      List<String> phoneNums = [];
      List<SmsMessage> _messages = await SmsQuery()
          .querySms(kinds: [SmsQueryKind.inbox, SmsQueryKind.sent]); //count: 1
      for (SmsMessage msg in _messages) {
        phoneNums.add(msg.sender.toString());
      }

      phoneNums = phoneNums.toSet().toList();

      for (String phone in phoneNums) {
        storeTxtMsgList.add(TextMessageFrequencyModel(
            phoneNo: phone,
            sendFrequency:
                "${_messages.where((e) => e.sender == phone && e.kind == SmsMessageKind.sent).length}",
            receivedFrequency:
                "${_messages.where((e) => e.sender == phone && e.kind == SmsMessageKind.received).length}"));

        // print(
        //     "$phone , SEND ${_messages.where((e) => e.sender == phone && e.kind == SmsMessageKind.sent).length}, REC ${_messages.where((e) => e.sender == phone && e.kind == SmsMessageKind.received).length}");
      }

      _bloc.storeTextMessageFrequency(storeTxtMsg: storeTxtMsgList);
    } else {
      _handleInvalidSMSPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getSMSPermission() async {
    PermissionStatus permission = await Permission.sms.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.sms.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidSMSPermissions(PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(
        msg: "Access to sms data denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
        msg: "SMS data not available on device",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    }
  }
}
