class AccountTokens {
  String? accessToken;
  String? refreshToken;
  String? accountId;

  AccountTokens({this.accessToken, this.refreshToken, this.accountId});

  AccountTokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['accountId'] = this.accountId;
    return data;
  }
}