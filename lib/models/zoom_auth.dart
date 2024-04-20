class ZoomAuth {
  String? accesstoken;
  int? expiresin;
  String? scope;
  String? tokentype;

  ZoomAuth({this.accesstoken, this.expiresin, this.scope, this.tokentype});

  ZoomAuth.fromJson(Map<String, dynamic> json) {
    accesstoken = json['access_token'];
    expiresin = json['expires_in'];
    scope = json['scope'];
    tokentype = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['access_token'] = accesstoken;
    data['expires_in'] = expiresin;
    data['scope'] = scope;
    data['token_type'] = tokentype;
    return data;
  }
}

