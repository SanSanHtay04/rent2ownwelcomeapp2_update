import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'app_status_response.freezed.dart';
part 'app_status_response.g.dart';

@freezed
class AppStatusResponse with _$AppStatusResponse {
  const AppStatusResponse._();

  const factory AppStatusResponse({
    @JsonKey(name: 'status_code') @Default('') String? code,
    @JsonKey(name: 'status_message') @Default('') String? message,
    @JsonKey(name: 'status') @Default(AppStatusType.notFound) AppStatusType appStatus,
    @JsonKey(name: 'message') @Default('') String? appMsg,
    @Default('') String? contactNo,
    @Default('') String? contactMsg,
  }) = _AppStatusResponse;

  factory AppStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$AppStatusResponseFromJson(json);
}

/*
{
    "status_code": "SUCCESS",
    "status_message": "Successfully logged in.",
    "access_token": "22618|2S5tG0VC3stb5pWS1VxmGj8O9JZoyiOKI1RwjRvN",
    "token_expiration": 86400
}
*/

/*
   {
        "status_code": "SUCCESS",
        "status_message": "",
        "status": "rejected",
        "message": "Unfortunately, We are sorry to inform you that your application was rejected due 
         to Rent2Own’s internal criteria."
        "contactNo": "",
        "contactMsg": "Due to the rejection, you will not be able to apply for Rent2Own’s services at th
         e moment."
   }
*/