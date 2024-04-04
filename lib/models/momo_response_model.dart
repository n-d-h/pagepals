class MoMoResponseModel {
  String? message;
  int? resultCode;
  String? payUrl;

  MoMoResponseModel({this.message, this.resultCode, this.payUrl});

  MoMoResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    resultCode = json['resultCode'];
    payUrl = json['payUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['resultCode'] = resultCode;
    data['payUrl'] = payUrl;
    return data;
  }
}