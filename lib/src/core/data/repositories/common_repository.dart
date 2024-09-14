import 'package:rent2ownwelcomeapp/src/core/core.dart';

class CommonRepository with BaseRepository {
  late CommonService api;

  CommonRepository({required this.api});

  Future<DataResponse<AppStatusResponse>> getApplicationStatus() {
    return handleRequestApi(
      handleDataRequest: () => api.getApplicationStatus(),
      handleDataResponse: (res) => res,
    );
  }

  Future<DataResponse<Map<String, dynamic>>> getContractInfo() {
    return handleRequestApi(
      handleDataRequest: () => api.getContractInfo(),
      handleDataResponse: (res) {
        AppLogger.i("API MESSAGE : ${res.message}");
        return res.data;
      },
    );
  }
}
