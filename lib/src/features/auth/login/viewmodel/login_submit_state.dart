
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/base/error.dart';

part 'login_submit_state.freezed.dart';

@freezed
class LoginSubmitState with _$LoginSubmitState {
  const factory LoginSubmitState.idle() = LoginSubmitStateIdle;

  const factory LoginSubmitState.loading() = LoginSubmitStateLoading;

  const factory LoginSubmitState.success(String data) =
      LoginSubmitStateSuccess;

  const factory LoginSubmitState.failed(String message, {AppError? error}) =
      LoginSubmitStateFailed;
}
