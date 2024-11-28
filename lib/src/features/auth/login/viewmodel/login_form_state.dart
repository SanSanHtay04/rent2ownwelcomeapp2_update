import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_form_state.freezed.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const LoginFormState._();

  const factory LoginFormState({
    @Default('') String phoneNumber,
  }) = _LoginFormState;
}

/*
String? username;
  String? password;
  LoginType loginType = LoginType.ONLINE;
  late String? androidId;
 */
