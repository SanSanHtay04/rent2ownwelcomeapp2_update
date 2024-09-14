import 'package:flutter/foundation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/home_data_state.dart';

class HomeViewModel extends ChangeNotifier {
  CommonRepository repo;
  HomeViewModel(this.repo);

  HomeDataState dataState = const HomeDataStateIdle();
  bool get isLoading => (dataState is HomeDataStateLoading);

  loadData() {
    checkAppStatus();
  }

  setDataState(HomeDataState value) {
    dataState = value;
    notifyListeners();
  }

  checkAppStatus() async {
    setDataState(const HomeDataStateIdle());

    final res = await repo.getApplicationStatus();

    final newState = res.when(
        success: (data) => HomeDataState.success(data),
        failed: (msg, error) => HomeDataStateFailed(msg, error: error));
    setDataState(newState);
  }
}
