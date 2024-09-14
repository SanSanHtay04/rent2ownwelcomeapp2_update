
import 'package:flutter/foundation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

import 'login_form_state.dart';
import 'login_submit_state.dart';


class LoginViewModel extends ChangeNotifier {
  AuthRepository repo;
  LoginViewModel(this.repo);

  LoginFormState formState = const LoginFormState();
  LoginSubmitState submitState = const LoginSubmitStateIdle();

  bool get isLoading => (submitState is LoginSubmitStateLoading);

  bool get enableButton => (!formState.phoneNumber.isNullOrEmpty);
  
  loadData(String phoneNo){
    AppLogger.i( "MOBILE NUMBER $phoneNo");
   updatePhoneNumber(phoneNo);
  }

  setFormState(LoginFormState value) {
    formState = value;
    notifyListeners();
  }

  updatePhoneNumber(String number) {
    setFormState(formState.copyWith(phoneNumber: number));
  }

  setSubmitState(LoginSubmitState value) {
    submitState = value;
    notifyListeners();
  }

  resetSubmitState (){
    setSubmitState(const LoginSubmitStateIdle());
  }

  generateOtp() async {
    if (formState.phoneNumber.isNullOrEmpty) return;

    setSubmitState(const LoginSubmitStateLoading());
    final res = await repo.otpLogin(formState.phoneNumber);

    final newState = res.when(
        success: (data) => LoginSubmitStateSuccess(data),
        failed: (msg, error) =>
            LoginSubmitStateFailed(msg, error: error));
    setSubmitState(newState);
  }
}
