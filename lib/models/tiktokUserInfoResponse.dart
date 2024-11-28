class TiktokUserInfoResponse {
  late TiktokErrorModel errorModel;
  late TiktokUserInfoModel userInfo;

  TiktokUserInfoResponse(json) {
    errorModel = TiktokErrorModel(json['error']);
    userInfo = TiktokUserInfoModel(json['data']['user']);
  }
}

class TiktokUserInfoModel {
  late String unionId;
  late String avatarUrl;
  late String openId;
  late String displayName;

  TiktokUserInfoModel(json) {
    unionId = json['profile_deep_link'] ?? ""; //union_id
    avatarUrl = json['avatar_url'] ?? "";
    openId = json['open_id'] ?? "";
    displayName = json['display_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['profile_deep_link'] = unionId;
    data['avatar_url'] = avatarUrl;
    data['open_id'] = openId;
    data['display_name'] = displayName;
    return data;
  }
}

class TiktokErrorModel {
  late String code;
  late String message;

  TiktokErrorModel(json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
