import 'package:flutter/foundation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

import 'contract_info_state.dart';

class ContractInfoNotifier extends ChangeNotifier {
  CommonRepository repo;
  ContractInfoNotifier(this.repo);

  ContractInfoState dataState = const ContractInfoStateIdle();
  bool get isLoading => (dataState is ContractInfoStateLoading);

  ContractInfoStateSuccess? get data =>
      dataState.mapOrNull(success: (value) => value);

  @override
  notifyListeners() {
    if (hasListeners) {
      super.notifyListeners();
    }
  }

 

  setDataState(ContractInfoState value) {
    dataState = value;
    notifyListeners();
  }

  getAppContractInfo() async {
    setDataState(const ContractInfoStateLoading());

    final res = await repo.getContractInfo();

    final newState = res.when(
        success: (data) => ContractInfoState.success(data),
        failed: (msg, error) => ContractInfoStateFailed(msg, error: error));
    setDataState(newState);
  }
}
