import 'dart:async';
import 'dart:convert';

import 'package:rent2ownwelcomeapp/models/appUsagePatternModel.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';
import 'package:rent2ownwelcomeapp/models/deviceInfoModel.dart';
import 'package:rent2ownwelcomeapp/models/downloadHistoryModel.dart';
import 'package:rent2ownwelcomeapp/models/storeTiktokModel.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';

import '../../../models/api_response.dart';
import '../../../models/callFrequencyModel.dart';
import '../../../models/response.dart';
import '../../../models/storeCallLogModel.dart';
import '../../../models/storeContactModel.dart';
import '../../../models/storeFacebookModel.dart';
import '../../../models/storeLocationModel.dart';
import '../../../models/storeSMSLogModel.dart';
import '../../../models/store_sim_card_model.dart';
import '../../../models/textMessageFrequencyModel.dart';
import '../../core/helpers/app_logger.dart';

class HomeBolc {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  //store location
  final StreamController<ApiResponse> _storeLocationController =
      StreamController.broadcast();
  Stream<ApiResponse> storeLocationStream() => _storeLocationController.stream;

  storeLocations({required List<StoreLocationModel> storeLocations}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = StoreLocationModel.toJsonList(storeLocations);
    final String requestBody = json.encoder.convert(bodyData);
    var res = await _apiBaseHelper.post(storeLiveLocationEndpoint, requestBody);
    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeLocationController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeLocationController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //store sim card
  final StreamController<ApiResponse> _storeContactConrtoller =
      StreamController.broadcast();
  Stream<ApiResponse> storeContactStream() => _storeContactConrtoller.stream;

  storeContacts(
      {required List<StoreSimCardModel> storeSims,
      required List<StoreContactModel> storeContacts,
      required List<StoreSMSLogModel> storeSMSs,
      required List<StoreCallLogModel> storeCalls}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = StoreContactModel.toJsonList(storeContacts);
    final String requestBody = json.encoder.convert(bodyData);
    var res = await _apiBaseHelper.post(storeContactApiEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeContactConrtoller.sink.add(responseOb);
      AppLogger.i(res.body);
      // storeSimCards(storeSimCards: storeSims);
      // storeSMSLogs(storeSMSs: storeSMSs, storeCalls: storeCalls);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeContactConrtoller.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

//store sim card
  final StreamController<ApiResponse> _storeSimCardConrtoller =
      StreamController.broadcast();
  Stream<ApiResponse> storeSimCardStream() => _storeSimCardConrtoller.stream;

  storeSimCards({required List<StoreSimCardModel> storeSimCards}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = StoreSimCardModel.toJsonList(storeSimCards);

    AppLogger.i("STORE SIMs => ${json.encode(bodyData)}");

    final String requestBody = json.encoder.convert(bodyData);
    var res = await _apiBaseHelper.post(storeSimCardApiEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeSimCardConrtoller.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeSimCardConrtoller.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //store SMS logs
  final StreamController<ApiResponse> _storeSMSController =
      StreamController.broadcast();
  Stream<ApiResponse> storeSMSStream() => _storeSMSController.stream;

  storeSMSLogs(
      {required List<StoreSMSLogModel> storeSMSs,
      required List<StoreCallLogModel> storeCalls}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = StoreSMSLogModel.toJsonList(storeSMSs);
    print("Raw bodyData: $bodyData");

    final String requestBody = json.encoder.convert(bodyData);
    var res = await _apiBaseHelper.post(storeSMSLogsApiEndpoint, requestBody);
    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeSMSController.sink.add(responseOb);
      AppLogger.i(res.body);
      // storeCallLogs(storeCallLogs: storeCalls);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeSMSController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //store Call Logs
  final StreamController<ApiResponse> _storeCallLogsController =
      StreamController.broadcast();
  Stream<ApiResponse> storeCallLogsStream() => _storeCallLogsController.stream;

  storeCallLogs({required List<StoreCallLogModel> storeCallLogs}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = StoreCallLogModel.toJsonList(storeCallLogs);

    final String requestBody = json.encoder.convert(bodyData);

    var res = await _apiBaseHelper.post(storeCallLogsApiEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeCallLogsController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeCallLogsController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  ////////
  //store facebook
  final StreamController<ApiResponse> _storeFacebookController =
      StreamController.broadcast();
  Stream<ApiResponse> storeFacebookStream() => _storeFacebookController.stream;

  storeFacebook({required StoreFacebookModel facebook}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    final String requestBody = json.encoder.convert(facebook);
    var res = await _apiBaseHelper.post(storeFacebookApiEndpoint, requestBody);

    // print("RB => $requestBody");

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeFacebookController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeFacebookController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //store TiktokInfo
  final StreamController<ApiResponse> _storeTiktokInfoController =
      StreamController.broadcast();
  Stream<ApiResponse> storeTiktokInfoStream() =>
      _storeTiktokInfoController.stream;

  storeTiktokInfo({required StoreTiktokModel tiktokInfo}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    final String requestBody = json.encoder.convert(tiktokInfo);
    var res = await _apiBaseHelper.post(storeTiktokApiEndpoint, requestBody);

    //print("RB => $requestBody");

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _storeTiktokInfoController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _storeTiktokInfoController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //get Application Status
  final StreamController<ApiResponse> _getApplicationStatusController =
      StreamController.broadcast();
  Stream<ApiResponse> getApplicationStatusStream() =>
      _getApplicationStatusController.stream;

  getApplicationStatus() async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    var res = await _apiBaseHelper.get(getApplicationStatusApiEndpoint);

    if (res.statusCode == 200) {
      ApplicationStatusResponse response =
          ApplicationStatusResponse(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _getApplicationStatusController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else if (res.statusCode == 401) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.forbiddenErr;
      _getApplicationStatusController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    } else if (res.statusCode == 500) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.serverErr;
      _getApplicationStatusController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;
      _getApplicationStatusController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }

  //store call duration and frequency
  storeCallDurationNFrequency(
      {required List<CallFrequencyModel> storeCallFrequency}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = CallFrequencyModel.toJsonList(storeCallFrequency);

    final String requestBody = json.encoder.convert(bodyData);

    var res = await _apiBaseHelper.post(
        storeCallDurationNFrequencyEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      AppLogger.e("Err ${res.body}");
    }
  }

  //store text message frequency
  storeTextMessageFrequency(
      {required List<TextMessageFrequencyModel> storeTxtMsg}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = TextMessageFrequencyModel.toJsonList(storeTxtMsg);

    final String requestBody = json.encoder.convert(bodyData);

    var res =
        await _apiBaseHelper.post(storeTextMsgFrequencyEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      AppLogger.e("Err ${res.body}");
    }
  }

  //store download history
  storeDownloadHistory(
      {required List<DownloadHistoryModel> storeDownloadHistory}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = DownloadHistoryModel.toJsonList(storeDownloadHistory);

    final String requestBody = json.encoder.convert(bodyData);

    var res =
        await _apiBaseHelper.post(storeAppDownloadHistoryEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      AppLogger.e("Err ${res.body}");
    }
  }

  //store app usage pattern
  storeAppUsagePattern(
      {required List<AppUsagePatternModel> storeAppUsagePattern}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    List bodyData = AppUsagePatternModel.toJsonList(storeAppUsagePattern);

    final String requestBody = json.encoder.convert(bodyData);

    var res =
        await _apiBaseHelper.post(storeAppUsagePatternEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      AppLogger.e("Err ${res.body}");
    }
  }

  //store app usage pattern
  storeDeviceInfo({required DeviceInfoModel deviceInfo}) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    final String requestBody = json.encoder.convert(deviceInfo);

    var res = await _apiBaseHelper.post(storeDeviceInfoEndpoint, requestBody);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      AppLogger.e("Err ${res.body}");
    }
  }
}
