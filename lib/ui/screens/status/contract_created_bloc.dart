import 'dart:async';
import 'dart:convert';

import 'package:rent2ownwelcomeapp/models/api_response.dart';
import 'package:rent2ownwelcomeapp/models/contractInfoResponse.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';

class ContractCreatedBloc {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  //get contract
  final StreamController<ApiResponse> _contractInfoController =
      StreamController.broadcast();
  Stream<ApiResponse> getContractInfoStream() => _contractInfoController.stream;

  getContractInfo() async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    var res = await _apiBaseHelper.get(getContractInfoApiEndpoint);

    if (res.statusCode == 200) {
      ContractInfoResponse response =
          ContractInfoResponse(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _contractInfoController.sink.add(responseOb);
      AppLogger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;
      _contractInfoController.sink.add(responseOb);
      AppLogger.e("Err ${res.body}");
    }
  }
}
