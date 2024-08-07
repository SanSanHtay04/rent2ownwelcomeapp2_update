import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent2ownwelcomeapp/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/models/storeTiktokModel.dart';
import 'package:rent2ownwelcomeapp/ui/screens/home/home_with_tab_screen.dart';
import 'package:rent2ownwelcomeapp/ui/screens/otp/otpBloc.dart';
import 'package:rent2ownwelcomeapp/ui/screens/otp/otpEvent.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../../../core/values/strings.dart';
import '../../../models/storeCallLogModel.dart';
import '../../../models/storeContactModel.dart';
import '../../../models/storeFacebookModel.dart';
import '../../../models/storeLocationModel.dart';
import '../../../models/storeSMSLogModel.dart';
import '../../../models/store_sim_card_model.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNum;
  final List<StoreSimCardModel> storeSims;
  final List<StoreContactModel> storeContacts;
  final List<StoreCallLogModel> storeCallLogs;
  final List<StoreSMSLogModel> storeSMSs;
  final List<StoreLocationModel> storeLocations;
  final StoreFacebookModel? storeFacebooks;
  final StoreTiktokModel? storeTiktokInfo;
  const OTPScreen({
    super.key,
    required this.phoneNum,
    required this.storeSims,
    required this.storeContacts,
    required this.storeCallLogs,
    required this.storeSMSs,
    required this.storeLocations,
    this.storeFacebooks,
    this.storeTiktokInfo,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _bloc = OTPBloc();

  final int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  bool _enableTryAgainButton = true;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");

  static const _timerDuration = 30;
  final StreamController _timerStream = StreamController<int>();
  late int timerCounter;
  late Timer _resendCodeTimer;

  String? signature;

  @override
  void initState() {
    super.initState();

    _bloc.getOtpCode(widget.phoneNum);

    _getSignatureCode();
    _startListeningSms();
    activeCounter();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
    _timerStream.close();
    _resendCodeTimer.cancel();
  }

  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0) {
        _timerStream.sink.add(_timerDuration - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer.cancel();
      }
    });
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    signature = await SmsVerification.getAppSignature();
    // print("signature $signature");
    // setState(() {});
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _otpCode = "";
      textEditingController.clear();
      _isLoadingButton = false;
      _enableButton = false;
    });
    _bloc.getOtpCode(widget.phoneNum);
    _startListeningSms();
    activeCounter();
  }

  bool _isTryAgainButtonRunning = false;
  Future _onPressed() async {
    setState(() {
      _isTryAgainButtonRunning = true;
    });

    await _onClickRetry();

    setState(() {
      _isTryAgainButtonRunning = false;
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _isLoadingButton = true;
        _enableButton = false;

        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _isLoadingButton = false;
        _enableButton = true;
      } else {
        _enableButton = true;
      }
    });
  }

  _verifyOtpCode() {
    // _saveUserLoginData();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return OTPEvent(
            phoneNum: widget.phoneNum,
            otpCode: _otpCode,
            callBack: () {
              // _saveUserLoginData();
              if (widget.storeFacebooks != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeWithTabScreen(
                        storeSims: widget.storeSims,
                        storeContacts: widget.storeContacts,
                        storeCallLogs: widget.storeCallLogs,
                        storeSMSs: widget.storeSMSs,
                        storeLocations: widget.storeLocations,
                        storeFacebooks: widget.storeFacebooks!,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              } else if (widget.storeTiktokInfo != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeWithTabScreen(
                        storeSims: widget.storeSims,
                        storeContacts: widget.storeContacts,
                        storeCallLogs: widget.storeCallLogs,
                        storeSMSs: widget.storeSMSs,
                        storeLocations: widget.storeLocations,
                        storeTiktokInfo: widget.storeTiktokInfo!,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeWithTabScreen(
                        storeSims: widget.storeSims,
                        storeContacts: widget.storeContacts,
                        storeCallLogs: widget.storeCallLogs,
                        storeSMSs: widget.storeSMSs,
                        storeLocations: widget.storeLocations,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              }
            },
          );
        });

    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            // Text("SIGNATURE => $signature"),
            Image.asset(
              "assets/images/home.png",
            ),
            Text(
              otp,
              style: GoogleFonts.comfortaa(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldPin(
                textController: textEditingController,
                autoFocus: true,
                codeLength: _otpCodeLength,
                alignment: MainAxisAlignment.center,
                defaultBoxSize: 46.0,
                margin: 10,
                selectedBoxSize: 46.0,
                textStyle: const TextStyle(fontSize: 16),
                selectedDecoration: _pinPutDecoration.copyWith(
                    color: const Color.fromRGBO(217, 217, 217, 0.51),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: const Color.fromRGBO(217, 217, 217, 0.51))),
                defaultDecoration: _pinPutDecoration.copyWith(
                    color: const Color.fromRGBO(217, 217, 217, 0.51),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: const Color.fromRGBO(217, 217, 217, 0.51))),
                onChange: (code) {
                  _onOtpCallBack(code, false);
                }),
            MaterialButton(
              onPressed: _enableButton ? _onSubmitOtp : null,
              color: Colors.blue,
              disabledColor: Colors.blue[100],
              child: _setUpButtonChild(),
            ),
            const Spacer(),
            StreamBuilder(
              stream: _timerStream.stream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                return Center(
                    child: snapshot.data == 0
                        ? TextButton(
                            onPressed: _isTryAgainButtonRunning
                                ? null
                                : () async => await _onPressed(),
                            child: Text(
                              tryAgain,
                              style: GoogleFonts.comfortaa(
                                  textStyle: const TextStyle(
                                      color: bg1Color, fontSize: 14)),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Please wait -  ${snapshot.hasData ? snapshot.data.toString() : 30} seconds to Try Again',
                                style: GoogleFonts.comfortaa(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 12)),
                              ),
                            ],
                          ));
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return const SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
