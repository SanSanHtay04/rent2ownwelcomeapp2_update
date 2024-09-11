import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/core/themes/dimensions.dart';
import 'package:rent2ownwelcomeapp/models/store_sim_card_model.dart';
import 'package:rent2ownwelcomeapp/ui/screens/auth/permission/logs/contactCallNSMSLogsCustomDialog.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/app_snack_bar.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/text_form_field/phone_text_form_field.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';
import 'package:rent2ownwelcomeapp/utils/utils.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  // To store Sim-Data from Device
  List<SimCard> _simCard = [];
  // Local Model to store Sim-Data
  List<StoreSimCardModel> storeSims = [];
  // Flags
  bool isInit = true;
  bool isEnable = true;

  var _initPhoneNumber = "";
  var _versionNumber = "";

  updatePhoneNumber(text) {
    setState(() {
      _initPhoneNumber = text;
    });
  }

  updateVersionNumber(text) {
    setState(() {
      _versionNumber = text;
    });
  }

  @override
  void initState() {
    super.initState();
    getVersionInfo().then(updateVersionNumber);

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (isInit) {
      if (!await MobileNumber.hasPhonePermission) {
        await MobileNumber.requestPhonePermission;
        return;
      }
      try {
        _simCard = (await MobileNumber.getSimCards)!;
      } on PlatformException catch (e) {
        AppLogger.e("Failed to get mobile number : ${e.message}");
      }

      if (!mounted) return;

      if (_simCard.isNotEmpty) {
        var simCardModel = StoreSimCardModel(
          simCardNo1: _simCard[0].format(),
          simCardNo2: (_simCard.length > 1) ? _simCard[1].format() : "",
        );
        storeSims.add(simCardModel);
        updatePhoneNumber(_simCard[0].number);
      }
      isInit = false;
      setState(() {});
    }
  }

  _showAppSettingsDialog() async {
    //if (await CheckVpnConnection.isVpnActive()) {
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

              if (storeSims.isEmpty) {
                storeSims.add(
                  StoreSimCardModel(simCardNo1: _initPhoneNumber),
                );
              }
              setState(() {
                isEnable = false;
              });
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black26,
                context: context,
                builder: (context) => ContactCallNSMSLogsCustomDialog(
                  phoneNumber: _initPhoneNumber,
                  storeSims: storeSims,
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    // } else {
    //   // ignore: use_build_context_synchronously
    //   return showDialog<String>(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('Connection request'),
    //       content: const Text(
    //           'Welcome app wants to set up VPN connection that allows it to monitor network traffic.'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             AppSettings.openAppSettings(type: AppSettingsType.vpn);
    //           },
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // }
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "WELCOME\n$_versionNumber",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      kSpaceVertical24,
                      PhoneTextFormField(
                        labelText: "Phone Number",
                        initialValue: _initPhoneNumber,
                        required: true,
                        onChanged: updatePhoneNumber,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              final isValidate =
                                  _formKey.currentState?.validate() ?? false;
                              if (!isValidate) {
                                "Notice: Please enter phone number starting with 09.[Example : 09xxxxxxxxx]"
                                    .showWarningSnackBar(context);
                              } else {
                                // _showAppSettingsDialog();

                                if (storeSims.isEmpty) {
                                  storeSims.add(
                                    StoreSimCardModel(
                                        simCardNo1: _initPhoneNumber),
                                  );
                                }
                                setState(() {
                                  isEnable = false;
                                });
                                showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.black26,
                                  context: context,
                                  builder: (context) =>
                                      ContactCallNSMSLogsCustomDialog(
                                    phoneNumber: _initPhoneNumber,
                                    storeSims: storeSims,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.getColorScheme().secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 180,
              right: 0,
              child: Image.asset("assets/images/home.png", height: 165),
            ),
          ],
        ),
      ),
    );
  }
}
