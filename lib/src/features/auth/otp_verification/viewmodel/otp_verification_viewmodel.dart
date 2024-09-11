import 'package:flutter/cupertino.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

import 'otp_verification_form_state.dart';
import 'otp_verification_submit_state.dart';

class OTPVerificationViewModel extends ChangeNotifier {
  AuthRepository repo;
  OTPVerificationViewModel(this.repo);

  loadData(String phoneNo) async {
    _setFormState(formState.copyWith(phoneNo: phoneNo));
  }

  OtpVerificationFormState formState = const OtpVerificationFormState();
  OtpVerificationSubmitState submitState =
      const OtpVerificationSubmitState.idle();

  bool get isLoading => (submitState is OtpVerificationSubmitStateLoading);

  bool get enableButton =>
      (!formState.otpCode.isNullOrEmpty && formState.otpCode.length == 4);

  _setFormState(OtpVerificationFormState value) {
    formState = value;
    notifyListeners();
  }

  updateOtpCode(String code,{ bool? isAutoFill = false}) {
    _setFormState(formState.copyWith(otpCode: code));
    /*
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
    }
    */


  }



  _setSubmitState(OtpVerificationSubmitState value) {
    submitState = value;
    notifyListeners();
  }


  void retryOtp() async{
    await updateOtpCode("");
     generateOtp();
  }

  generateOtp() async {
    _setSubmitState(const OtpVerificationSubmitStateLoading());
    final res = await repo.otpLogin(formState.phoneNo);

    final newState = res.when(
        success: (data) => const OtpVerificationSubmitStateIdle(),
        failed: (msg, error) =>
            OtpVerificationSubmitStateFailed(msg, error: error),);

    _setSubmitState(newState);
  }


  resetSubmitState() {
    _setSubmitState(const OtpVerificationSubmitStateIdle());
  }

  void verifyOTP() async {
    _setSubmitState(const OtpVerificationSubmitStateLoading());
    final res = await repo.verifyOTP(
      formState.phoneNo,
      formState.otpCode,
    );

    final newState = res.when(
      success: (_) => const OtpVerificationSubmitStateSuccess(),
      failed: (msg, err) => OtpVerificationSubmitStateFailed(msg, error: err),
    );
    _setSubmitState(newState);
  }
}
