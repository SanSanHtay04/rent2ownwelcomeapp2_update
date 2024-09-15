import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

part 'contract_info_response.freezed.dart';
part 'contract_info_response.g.dart';

@freezed
class ContractInfoResponse with _$ContractInfoResponse {
  const ContractInfoResponse._();

  const factory ContractInfoResponse({
    @JsonKey(name: "status_code") required String statusCode,
    @JsonKey(name: "status_message") required String statusMessage,
    @Default('') String? contractNo,
    @Default([]) List<String>? termsAndConditions,
    @Default('') String? paymentSchedule,
    @Default('') String? contractDetailLink,
    @Default([]) List<String>? hotLineNo,
  }) = _ContractInfoResponse;

  factory ContractInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractInfoResponseFromJson(json);
}

/*
  late String statusCode;
  late String statusMessage;
  late String contractNo;
  late List<String> termsAndConditions;
  late String paymentSchedule;
  late String contractDetailLink;
  late List<String> hotLineNo;

  ContractInfoResponse(json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    if (statusCode.toLowerCase() == "success") {
      contractNo = json['contractNo'];
      paymentSchedule = json['paymentSchedule'];
      contractDetailLink = json['contractDetailLink'];

      List<String> tNcTemp = [];
      for (int i = 0; i < json['termsAndConditions'].length; i++) {
        String tNC = json['termsAndConditions'][i];
        tNcTemp.add(tNC);
      }
      termsAndConditions = tNcTemp;

      List<String> hlTemp = [];
      for (int j = 0; j < json['hotLineNo'].length; j++) {
        String hl = json['hotLineNo'][j];
        hlTemp.add(hl);
      }
      hotLineNo = hlTemp;
    }
  } moment."
   }
*/