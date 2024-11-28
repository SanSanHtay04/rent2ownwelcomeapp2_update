class Response {
  late String statusCode;
  late String statusMessage;

  Response(json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    return data;
  }
}
