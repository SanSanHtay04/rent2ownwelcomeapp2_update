class ContractInfoResponse {
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
  }
}
