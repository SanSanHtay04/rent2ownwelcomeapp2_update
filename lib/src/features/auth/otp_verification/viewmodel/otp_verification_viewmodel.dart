import 'package:flutter/cupertino.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/widgets/otp_verification_form.dart';

import 'otp_verification_form_state.dart';
import 'otp_verification_submit_state.dart';

class OTPVerificationViewModel extends ChangeNotifier {
  AuthRepository repo;
  OTPVerificationViewModel(this.repo);

  loadData(String phoneNo) {
    AppLogger.i( "PHONE : $phoneNo");
    _setFormState(formState.copyWith(phoneNo: phoneNo));
    //generateOtp();
  }

  OtpVerificationFormState formState = const OtpVerificationFormState();
  OtpVerificationSubmitState submitState =
      const OtpVerificationSubmitState.idle();

  bool enableVerifyButton = false;
  bool enableLodaingButton = false;

  bool get isLoading =>
      (formState.status == IssueOtpState.loading) ||
      (submitState is OtpVerificationSubmitStateLoading);

  _setFormState(OtpVerificationFormState value) {
    formState = value;
    notifyListeners();
  }

  resetFormState() {
    _setFormState(formState.copyWith(
      status: IssueOtpState.loaded,
      otpCode: "",
    ));
  }

  updateOtpCode(String code, {bool isAutoFill = false}) {
    _setFormState(formState.copyWith(otpCode: code));
    if (code.length == OTP_CODE_SIZE && isAutoFill) {
      enableVerifyButton = false;
      enableLodaingButton = true;

      verifyOTP();
    } else if (code.length == OTP_CODE_SIZE && !isAutoFill) {
      enableVerifyButton = true;
      enableLodaingButton = false;
    } else {
      enableVerifyButton = false;
    }
    notifyListeners();
  }

  _setSubmitState(OtpVerificationSubmitState value) {
    submitState = value;
    notifyListeners();
  }

  generateOtp() async {
    _setFormState(formState.copyWith(status: IssueOtpState.loading));
    AppLogger.i("VERIFY OTP : ${formState.phoneNo}");
    final res = await repo.otpLogin(formState.phoneNo);
    final newState = res.when(
        success: (data) => formState.copyWith(
              status: IssueOtpState.loaded,
              message: data,
            ),
        failed: (msg, err) => formState.copyWith(
              status: IssueOtpState.failed,
              message: msg,
              error: err,
            ));
    _setFormState(newState);
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
