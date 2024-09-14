import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'otp_verification_form_state.freezed.dart';

enum IssueOtpState { loading, loaded, failed }

@freezed
class OtpVerificationFormState with _$OtpVerificationFormState {
  const OtpVerificationFormState._();

  const factory OtpVerificationFormState({
    @Default(IssueOtpState.loaded) IssueOtpState status,
    String? message,
    AppError? error,
    @Default('') String phoneNo,
    @Default('') String otpCode,
  }) = _OtpVerificationFormState;
}
