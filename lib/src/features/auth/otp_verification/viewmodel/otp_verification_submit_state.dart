import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'otp_verification_submit_state.freezed.dart';

@freezed
class OtpVerificationSubmitState with _$OtpVerificationSubmitState {
  const factory OtpVerificationSubmitState.idle() = OtpVerificationSubmitStateIdle;

  const factory OtpVerificationSubmitState.loading() = OtpVerificationSubmitStateLoading;

  const factory OtpVerificationSubmitState.success() = OtpVerificationSubmitStateSuccess;

  const factory OtpVerificationSubmitState.failed(String message, {AppError? error}) = OtpVerificationSubmitStateFailed;
}
