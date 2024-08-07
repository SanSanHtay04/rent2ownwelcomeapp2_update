import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/core/themes/dimensions.dart';
import 'package:rent2ownwelcomeapp/models/store_sim_card_model.dart';
import 'package:rent2ownwelcomeapp/ui/screens/auth/permission/logs/contactCallNSMSLogsCustomDialog.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/app_snack_bar.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/text_form_field/phone_text_form_field.dart';
import 'package:rent2ownwelcomeapp/utils/utils.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //TODO : Move state values to State layer / not in UI layer
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isEnable = true;
  List<SimCard> _simCard = [];
  List<StoreSimCardModel> _storedSimCards = [];

  var _initPhoneNumber = "";
  onPhoneNumberChanged(text) {
    setState(() {
      _initPhoneNumber = text;
    });
  }

  @override
  void initState() {
    super.initState();

    MobileNumber.listenPhonePermission(
      (isPermissionGranted) =>
          (isPermissionGranted) ? initMobileNumberState() : null,
    );
    initMobileNumberState();
  }

  // Handle phone_number permission
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    try {
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;
    setState(() {});

    print("_simCard Length => ${_simCard.length}");

    if (_simCard.isNotEmpty) {
      var simCardModel = StoreSimCardModel(
        simCardNo1: _simCard[0].format(),
        simCardNo2: (_simCard.length > 1) ? _simCard[1].format() : "",
      );
      _storedSimCards.add(simCardModel);
      onPhoneNumberChanged(_simCard[0].number);
    }
  }

  _showAppSettingsDialog() async {
    // if (await CheckVpnConnection.isVpnActive()) {
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

              if (_storedSimCards.isEmpty) {
                _storedSimCards.add(
                  StoreSimCardModel(simCardNo1: _initPhoneNumber),
                );
              }

              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return ContactCallNSMSLogsCustomDialog(
                    phoneNumber: _initPhoneNumber,
                    storeSims: _storedSimCards,
                  );
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 150,
              right: 0,
              child: Image.asset(height: 165, "assets/images/home.png"),
            ),
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
                       const Text("WELCOME",
                       textAlign: TextAlign.center,
                        style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      kSpaceVertical24,
                      PhoneTextFormField(
                        labelText: "Phone Number",
                        initialValue: _initPhoneNumber,
                        required: true,
                        onChanged: onPhoneNumberChanged,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _showAppSettingsDialog();
                                // context.showPermissionDialog(
                                //   imagePath: "assets/icons/logs.png",
                                //   message:
                                //       "Allow contact, call and sms permission access to R2O for better Customer Services.",
                                //   onConfirmPressed: () {},
                                //   onCancelPressed: AppSettings.openAppSettings,
                                // );
                              } else {
                                AppSnackBar.showErrorSnackBar(
                                    "Notice: Please enter phone number starting with 09. Do not enter \'95\'. \n[Example : 09xxxxxxxxx]");
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
          ],
        ),
      ),
    );
  }
}

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required List<StoreSimCardModel> storedSimCards,
    required String phoneNumber,
  })  : _formKey = formKey,
        _storedSimCards = storedSimCards,
        _phoneNumber = phoneNumber;

  final GlobalKey<FormState> _formKey;
  final List<StoreSimCardModel> _storedSimCards;
  final String _phoneNumber;

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  _onLoginButtonClicked(BuildContext context) async {
    // if (
    //   widget._storedSimCards.isEmpty) {
    //   _storedSimCards.add(
    //     StoreSimCardModel(simCardNo1: _initPhoneNumber),
    //   );
    // }

    // TODO : refactor this widgets with custom bottom sheet in later
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return ContactCallNSMSLogsCustomDialog(
          phoneNumber: widget._phoneNumber,
          storeSims: widget._storedSimCards,
        );
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
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            if (widget._formKey.currentState?.validate() ?? false) {
              // context.showPermissionDialog(
              //   imagePath: "assets/icons/logs.png",
              //   message:
              //       "Allow contact, call and sms permission access to R2O for better Customer Services.",
              //   onConfirmPressed: () {},
              //   onCancelPressed: AppSettings.openAppSettings,
              // );
            } else {
              AppSnackBar.showErrorSnackBar(
                  "Notice: Please enter phone number starting with 09. Do not enter \'95\'. \n[Example : 09xxxxxxxxx]");
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
    );
  }
}
