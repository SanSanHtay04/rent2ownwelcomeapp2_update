class VerifyOtpReponse {
  late String statusCode;
  late String statusMessage;
  late String accessToken;

  VerifyOtpReponse(json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    data['access_token'] = accessToken;
    return data;
  }
}
