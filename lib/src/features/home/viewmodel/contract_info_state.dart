import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'contract_info_state.freezed.dart';
@freezed
class ContractInfoState with _$ContractInfoState {
  const factory ContractInfoState.idle() = ContractInfoStateIdle;

  const factory ContractInfoState.loading() = ContractInfoStateLoading;

  const factory ContractInfoState.success(ContractInfoResponse response) = ContractInfoStateSuccess;

  const factory ContractInfoState.failed(String message, {AppError? error}) =
      ContractInfoStateFailed;
  
}
