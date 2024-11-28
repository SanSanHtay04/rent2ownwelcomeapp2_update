class ApplicationStatusResponse {
  late String statusCode;
  late String statusMessage;
  late String status;
  late String message;
  late String contactNo;
  late String contactMsg;

  ApplicationStatusResponse(json) {
    statusCode = json['status_code'];
    if (statusCode.toLowerCase() == "success") {
      statusMessage = json['status_message'];
      status = json['status'];
      message = json['message'];
      contactNo = json['contactNo'];
      contactMsg = json['contactMsg'];
    } else {
      status = json['status_code'];
      statusMessage = json['status_message'];
    }
  }
}
