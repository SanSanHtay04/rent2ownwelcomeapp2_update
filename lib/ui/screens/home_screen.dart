import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rent2ownwelcomeapp/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/core/values/strings.dart';
import 'package:rent2ownwelcomeapp/models/storeCallLogModel.dart';
import 'package:rent2ownwelcomeapp/models/storeContactModel.dart';
import 'package:rent2ownwelcomeapp/models/storeFacebookModel.dart';
import 'package:rent2ownwelcomeapp/models/storeSMSLogModel.dart';
import 'package:rent2ownwelcomeapp/models/store_sim_card_model.dart';
import 'package:rent2ownwelcomeapp/models/storeTiktokModel.dart';
import 'package:rent2ownwelcomeapp/ui/screens/home/homeBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/storeLocationModel.dart';
import '../../../network/api/api_constant.dart';
import '../../../utils/logger.dart';

class HomeScreen extends StatefulWidget {
  final bool isAldLogin;
  final List<StoreSimCardModel>? storeSims;
  final List<StoreContactModel>? storeContacts;
  final List<StoreCallLogModel>? storeCallLogs;
  final List<StoreSMSLogModel>? storeSMSs;
  final List<StoreLocationModel>? storeLocations;
  final StoreFacebookModel? storeFacebooks;
  final StoreTiktokModel? storeTiktokInfo;

  const HomeScreen(
      {Key? key,
      this.isAldLogin = false,
      this.storeSims,
      this.storeContacts,
      this.storeCallLogs,
      this.storeSMSs,
      this.storeLocations,
      this.storeFacebooks,
      this.storeTiktokInfo})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBolc _bloc = HomeBolc();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    //checkUserStatus();
  }

  Future<void> _saveUserLoginData() async {
    SharedPreferences spfs = await SharedPreferences.getInstance();
    spfs.setBool(IS_ALD_LOGIN, true);
  }

  checkUserStatus() async {
    if (widget.isAldLogin) {
      // print("ALD LOGIN USER");
      getCurrentLocation(); //Update location
    } else {
      _saveUserLoginData();
      // print("NEW USER");
      // print("SIMS => ${widget.storeSims!.length}");
      // print("CONTACTS => ${widget.storeContacts!.length}");
      // print("CALL LOGS => ${widget.storeCallLogs!.length}");
      // print("SMSs => ${widget.storeSMSs!.length}");
      // print("LOCATIONS => ${widget.storeLocations!.length}");
      // print("FB => ${widget.storeFacebooks!.email}");
      // print("TT => " + json.encode(widget.storeTiktokInfo));

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

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return LocationEvent(
    //         storeLocations: storeLocations,
    //         callBack: () {
    //           Navigator.of(context).pop(true);
    //           showDialog(
    //             barrierDismissible: false,
    //             barrierColor: Colors.black26,
    //             context: context,
    //             builder: (context) {
    //               return SocialMediaCustomDialog();
    //             },
    //           );
    //         },
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: bgColor,
          title: Image.asset(
            "assets/images/home.png",
            width: 150,
          ),
        ),
        body: Column(
          children: [
            _successWidget(),
            // _accInfoWidget()
          ],
        ),
      ),
    );
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

  // Widget _accInfoWidget() {
  //   return Container(
  //       margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
  //       padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
  //       decoration: BoxDecoration(
  //           color: Color(0xFFFFFFFF),
  //           border: Border.all(
  //               style: BorderStyle.solid, width: 0.25, color: bg2Color),
  //           borderRadius: const BorderRadius.all(Radius.circular(20))),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             width: 36,
  //             height: 60,
  //             decoration: BoxDecoration(
  //                 color: Color(0xFFFFFFFF),
  //                 border: Border.all(
  //                     style: BorderStyle.solid,
  //                     width: 0.25,
  //                     color: borderColor),
  //                 borderRadius: const BorderRadius.all(Radius.circular(20))),
  //             child: Center(
  //               child: Image.asset("assets/icons/congrat.png"),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Text(
  //               accInfoMessage,
  //               textAlign: TextAlign.justify,
  //               style: GoogleFonts.comfortaa(
  //                   textStyle: const TextStyle(
  //                       fontStyle: FontStyle.normal,
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 12)),
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  Widget _successWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
          color: bg1Color,
          border: Border.all(
              style: BorderStyle.solid,
              width: 0.25,
              color: const Color(0xFFDADADA)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Text(
        successMessage,
        textAlign: TextAlign.justify,
        style: GoogleFonts.comfortaa(
            textStyle: const TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12)),
      ),
    );
  }
}
