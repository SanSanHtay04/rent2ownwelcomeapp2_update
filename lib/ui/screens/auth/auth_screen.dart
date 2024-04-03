import 'dart:convert';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/models/storeSimCardModel.dart';
import 'package:rent2ownwelcomeapp/ui/screens/auth/permission/logs/contactCallNSMSLogsCustomDialog.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import 'permission/location/locationCustomDialog.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneNoTEC = TextEditingController();
  List<SimCard> _simCard = [];
  List<StoreSimCardModel> storeSims = [];
  bool isInit = true;
  bool isEnable = true;

  @override
  void initState() {
    super.initState();
    //print("ISINIT1 $isInit");

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (isInit) {
      storeSims = [];
      if (!await MobileNumber.hasPhonePermission) {
        await MobileNumber.requestPhonePermission;
        return;
      }
      try {
        _simCard = (await MobileNumber.getSimCards)!;
      } on PlatformException catch (e) {
        //debugPrint("Failed to get mobile number because of '${e.message}'");
      }

      if (!mounted) return;

      // print("SIM => ${_simCard.length}");

      // print("Mobile No => $_mobileNumber");

      if (_simCard.length > 1) {
        bool isStore = false;
        for (int i = 0; i < _simCard.length; i++) {
          if (_simCard[i].number!.isNotEmpty) {
            isStore = true;
          } else {
            isStore = false;
          }
        }

        if (isStore) {
          StoreSimCardModel sim = StoreSimCardModel(
              simCardNo1:
                  "(${_simCard[0].countryPhonePrefix}) - ${_simCard[0].number}",
              simCardNo2:
                  "(${_simCard[1].countryPhonePrefix}) - ${_simCard[1].number}");
          storeSims.add(sim);
          // print(json.encode(sim));
        }

        phoneNoTEC.text = _simCard[0].number.toString();
      } else if (_simCard.length == 1) {
        StoreSimCardModel sim = StoreSimCardModel(
            simCardNo1:
                "(${_simCard[0].countryPhonePrefix}) - ${_simCard[0].number}",
            simCardNo2: "");

        if (sim.simCardNo1.isNotEmpty) {
          storeSims.add(sim);
          //  print(json.encode(sim));
          phoneNoTEC.text = _simCard[0].number.toString();
        } else {}
      } else {}

      isInit = false;
    }

    // setState(() {});
  }

  _showAppSettingsDialog() async {
    if (await CheckVpnConnection.isVpnActive()) {
      // do some action if VPN connection status is true
      // ignore: use_build_context_synchronously
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'This app may not work correctly without the requested permissions.Open app settings screen to modify app permissions.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openAppSettings(type: AppSettingsType.settings);

                String phoneNo = phoneNoTEC.text.toString();

                setState(() {
                  isEnable = false;
                });

                if (storeSims.isEmpty) {
                  StoreSimCardModel sim =
                      StoreSimCardModel(simCardNo1: phoneNo, simCardNo2: "");

                  storeSims.add(sim);
                }

                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.black26,
                  context: context,
                  builder: (context) {
                    return ContactCallNSMSLogsCustomDialog(
                        phoneNumber: phoneNo, storeSims: storeSims);
                    /*  if (Platform.isAndroid) {
                      return ContactCallNSMSLogsCustomDialog(
                          phoneNumber: phoneNo, storeSims: storeSims);
                    } else {
                      return LocationCustomDialog(
                        phoneNumber: phoneNo,
                        storeSims: storeSims,
                        storeContacts: [],
                        storeSMSs: [],
                        storeCallLogs: [],
                      );
                    }*/
                  },
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Connection request'),
          content: const Text(
              'Welcome app wants to set up VPN connection that allows it to monitor network traffic.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openAppSettings(type: AppSettingsType.vpn);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              bottom: -160,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.84,
                decoration: const BoxDecoration(
                  color: Color(0xFF039370),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(500),
                      topRight: Radius.circular(500)),
                ),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 320,
                    decoration: const BoxDecoration(
                      color: Color(0xFF91D234),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(320),
                          topRight: Radius.circular(320)),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("WELCOME",
                        style: GoogleFonts.comfortaa(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                        enabled: isEnable,
                        keyboardType: TextInputType.phone,
                        controller: phoneNoTEC,
                        obscureText: false,
                        style: GoogleFonts.comfortaa(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                          hintText: "Phone Number",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              //To get packet MD5 code for tiktok
                              // PackageInfo packageInfo =
                              //     await PackageInfo.fromPlatform();

                              // String appName = packageInfo.appName;
                              // String packageName = packageInfo.packageName;
                              // String version = packageInfo.version;
                              // String buildNumber = packageInfo.buildNumber;
                              // String buildSignature =
                              //     packageInfo.buildSignature;

                              // print("SIGNSTURE => $buildSignature");

                              // var bytes = utf8
                              //     .encode(buildSignature); // data being hashed

                              // var digest = md5.convert(bytes);

                              // print("Digest as bytes: ${digest.bytes}");
                              // print(
                              //     "Digest as hex string: $digest"); //7049a902bec24cdaed0459c2746f4030 //b45cffe084dd3d20d928bee85e7b0f21 OLD MD5 code
                            },
                            child: Text("Create New Account",
                                style: GoogleFonts.comfortaa(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.black),
                                ))),
                        TextButton(
                            onPressed: () async {
                              if (phoneNoTEC.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: phoneNoerrorMessage,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: errTxtColor,
                                  fontSize: 12.0,
                                );
                              } else {
                                _showAppSettingsDialog();
                              }
                            },
                            child: Text("Log-in",
                                style: GoogleFonts.comfortaa(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF91D234)),
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 180,
              right: 0,
              child: Image.asset(
                "assets/images/home.png",
                height: 165,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
