import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'home_data_state.freezed.dart';
@freezed
class HomeDataState with _$HomeDataState {
  const factory HomeDataState.idle() = HomeDataStateIdle;

  const factory HomeDataState.loading() = HomeDataStateLoading;

  const factory HomeDataState.success(AppStatusResponse data) = HomeDataStateSuccess;

  const factory HomeDataState.failed(String message, {AppError? error}) =
      HomeDataStateFailed;
}
