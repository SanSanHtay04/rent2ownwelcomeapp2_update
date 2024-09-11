import 'package:rent2ownwelcomeapp/src/core/core.dart';

class AuthRepository with BaseRepository {
  late AuthService _api;
  late PrefsStore _prefsStore;

  AuthRepository({required AuthService api, required PrefsStore prefsStore}) {
    _api = api;
    _prefsStore = prefsStore;
  }

  Future<DataResponse<String>> otpLogin(String phoneNo) {
    return handleRequestApi<LoginOtpResponse, String>(
      handleDataRequest: () {
        final request = {"phoneNo": phoneNo};
        return _api.otpLogin(request);
      },
      handleDataResponse: (LoginOtpResponse res) => res.message ?? "",
    );
  }

  Future<DataResponse<void>> verifyOTP(String phoneNo, String code) {
    return handleRequestApi(
      handleDataRequest: () {
        final request = {
          "phoneNo": phoneNo,
          "otpCode": code,
        };

        return _api.verifyOTP(request);
      },
      handleDataResponse: (VerifyOtpResponse res) async {
        if (res.code == "SUCCESS") {
          _prefsStore.setAccountInfo(res);
        }
        throw res.message ?? defaultErrorMessage;
      },
    );
  }

  Future<void> logout() async {
    // Clear local data first coz error could occur on api call!
    _prefsStore.clearAccountInfo();
    //_api.logout();
  }
}
