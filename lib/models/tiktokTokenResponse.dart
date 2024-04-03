class TiktokTokenResponse {
  late String accessToken;
  late String expiresIn;
  late String openId;
  late String refreshExpiresIn;
  late String refreshToken;
  late String scope;
  late String tokenType;

  TiktokTokenResponse(json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'].toString();
    openId = json['open_id'];
    refreshExpiresIn = json['refresh_expires_in'].toString();
    refreshToken = json['refresh_token'];
    scope = json['scope'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['open_id'] = openId;
    data['refresh_expires_in'] = refreshExpiresIn;
    data['refresh_token'] = refreshToken;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    return data;
  }
}

class TTTokenError {
  late String error;
  TTTokenError(json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['error'] = error;
    return data;
  }
}
