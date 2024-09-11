import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verification_form_state.freezed.dart';

@freezed
class OtpVerificationFormState with _$OtpVerificationFormState {
  const OtpVerificationFormState._();

  const factory OtpVerificationFormState({
    @Default('') String phoneNo,
    @Default('') String otpCode,
  }) = _OtpVerificationFormState;
}
