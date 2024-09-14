import 'package:rent2ownwelcomeapp/src/core/core.dart';

class MiscRepository with BaseRepository {
  late MiscService api;

  MiscRepository({required this.api});

  Future<DataResponse<void>> uploadSimCards(List<DeviceSimRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeSimCard(data);
      },
      handleDataResponse: (res) {
        AppLogger.i("API MESSAGE : ${res.message}");
      },
    );
  }

  Future<DataResponse<void>> uploadContacts(List<ContactRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeContact(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadCallLogs(List<CallLogRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeCallLog(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadSmsLogs(List<SmsLogRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeSmsLog(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadLocations(List<LiveLocationRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeLiveLocation(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadFacebookInfo(SocialFacebookRequest data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeFacebook(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadTiktokInfo(SocialTiktokRequest data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeTiktok(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadCallFrequency(
      List<CallFrequencyRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeCallFrequency(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadSmsFrequency(
      List<SmsFrequencyRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeSmsFrequency(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadAppHistory(List<AppHistoryRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeAppHistory(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadAppUsage(List<AppUsageRequest> data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeAppUsage(data);
      },
      handleDataResponse: (res) {},
    );
  }

  Future<DataResponse<void>> uploadDeviceInfo(DeviceInfoRequest data) {
    return handleRequestApi(
      handleDataRequest: () {
        return api.storeDeviceInfo(data);
      },
      handleDataResponse: (res) {},
    );
  }
}
