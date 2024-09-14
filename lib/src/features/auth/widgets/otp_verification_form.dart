import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/otp_verification/viewmodel/otp_verification_viewmodel.dart';

import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import 'otp_timer.dart';

const int OTP_CODE_SIZE = 4;

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({super.key, required this.vm});

  final OTPVerificationViewModel vm;

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    AppLogger.i("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      final otpCode = SmsVerification.getCode(message, intRegex);
      widget.vm.updateOtpCode(otpCode, isAutoFill: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = widget.vm.formState.otpCode;
    Widget textFieldPin = TextFieldPin(
      textController: textEditingController,
      autoFocus: true,
      codeLength: OTP_CODE_SIZE,
      alignment: MainAxisAlignment.center,
      defaultBoxSize: 46.0,
      margin: 10,
      selectedBoxSize: 46.0,
      textStyle: TextStyle(fontSize: 16, color: Colors.black),
      selectedDecoration: _pinPutDecoration.copyWith(
          color: const Color.fromRGBO(217, 217, 217, 0.51),
          borderRadius: kBorderRadius8,
          border: Border.all(color: const Color.fromRGBO(217, 217, 217, 0.51))),
      defaultDecoration: _pinPutDecoration.copyWith(
          color: const Color.fromRGBO(217, 217, 217, 0.51),
          borderRadius: kBorderRadius8,
          border: Border.all(color: const Color.fromRGBO(217, 217, 217, 0.51))),
      onChange: (code) => widget.vm.updateOtpCode(code),
    );

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textFieldPin,
          kSpaceVertical20,
          Row(children: [
            Expanded(
                child: ElevatedButton(
              onPressed:
                  widget.vm.enableVerifyButton ? widget.vm.verifyOTP : null,
              child: _setUpButtonChild(),
            )),
          ]),
          kSpaceVertical20,
          OtpTimer(
            vm: widget.vm,
            smsListener: _startListeningSms,
          )
        ],
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  Widget _setUpButtonChild() => (widget.vm.enableLodaingButton)
      ? const SizedBox(
          width: 19,
          height: 19,
          child: CircularProgressIndicator(),
        )
      : const Text("Verify");
}
