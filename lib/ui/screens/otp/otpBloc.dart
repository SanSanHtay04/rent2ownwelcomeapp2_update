import 'dart:async';
import 'dart:convert';

import 'package:rent2ownwelcomeapp/models/api_response.dart';
import 'package:rent2ownwelcomeapp/models/response.dart';
import 'package:rent2ownwelcomeapp/models/verifyOtpReponse.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';

class OTPBloc {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  //get otp code
  final StreamController<ApiResponse> _otpCodeController =
      StreamController.broadcast();
  Stream<ApiResponse> otpCodeStream() => _otpCodeController.stream;

  getOtpCode(String phoneNum) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    var map = Map<String, dynamic>();
    map['phoneNo'] = phoneNum;
    var res = await _apiBaseHelper.postFD(postPhoneNoToGetOTPEndpoint, map);

    if (res.statusCode == 200) {
      Response response = Response(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _otpCodeController.sink.add(responseOb);
      logger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;

      _otpCodeController.sink.add(responseOb);
      logger.e("Err ${res.body}");
    }
  }

  //verify OTP code
  final StreamController<ApiResponse> _verifyOTPController =
      StreamController.broadcast();
  Stream<ApiResponse> verifyOTPStream() => _verifyOTPController.stream;

  verifyOTPCode(String phoneNum, String otpCode) async {
    ApiResponse responseOb =
        ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr);

    var map = Map<String, dynamic>();
    map['phoneNo'] = phoneNum;
    map['otpCode'] = otpCode;
    var res = await _apiBaseHelper.postFD(verifyPhoneNoEndpoint, map);

    if (res.statusCode == 200) {
      VerifyOtpReponse response = VerifyOtpReponse(json.decode(res.body));
      responseOb.data = response;
      responseOb.msgState = MsgState.data;
      _verifyOTPController.sink.add(responseOb);
      logger.i(res.body);
    } else {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errorState = ErrorState.unknownErr;
      _verifyOTPController.sink.add(responseOb);
      logger.e("Err ${res.body}");
    }
  }
}
