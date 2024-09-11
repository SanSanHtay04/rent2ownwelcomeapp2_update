import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/src/core/values/strings.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/otp_verification/viewmodel/otp_verification_viewmodel.dart';
import 'package:rent2ownwelcomeapp/src/features/otp/otpBloc.dart';

import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({super.key, required this.vm});

  final OTPVerificationViewModel vm;

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");


  final int TIMER_DURATION = 30;
  final StreamController _timerStream = StreamController<int>();
  late int timerCounter;
  late Timer _resendCodeTimer;


  @override
  void initState() {
    super.initState();
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

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    AppLogger.i("signature $signature");
  }

  /// listen sms
  _startListeningSms()  {
     SmsVerification.startListeningSms().then((message) {
      final otpCode = SmsVerification.getCode(message, intRegex);
       textEditingController.text = otpCode;
       _onOtpCallBack(otpCode, true);  
    });
  }


  
  ///  START OF SMS OTP SERVICE
   _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    textEditingController.clear();
    widget.vm.retryOtp();

   _startListeningSms();
    activeCounter();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    widget.vm.updateOtpCode(otpCode);
    setState(() {      
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    widget.vm.verifyOTP();
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });
  }

  /// END OF SMS SERVICES




  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (TIMER_DURATION - timer.tick > 0) {
        _timerStream.sink.add(TIMER_DURATION - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer.cancel();
      }
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
            kSpaceVertical20,

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
              onChange: widget.vm.updateOtpCode,
            ),

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
                            onPressed:
                                widget.vm.isLoading ? null : _onClickRetry,
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
          ],
        ),
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
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
