class RequestModel {
  String? createdAt;
  String? description;
  String? id;
  String? interviewAt;
  String? meetingCode;
  String? staffId;
  String? staffName;
  String? state;
  String? updatedAt;

  RequestModel({this.createdAt, this.description, this.id, this.interviewAt, this.meetingCode, this.staffId, this.staffName, this.state, this.updatedAt});

  RequestModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    id = json['id'];
    interviewAt = json['interviewAt'];
    meetingCode = json['meetingCode'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    state = json['state'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['interviewAt'] = interviewAt;
    data['meetingCode'] = meetingCode;
    data['staffId'] = staffId;
    data['staffName'] = staffName;
    data['state'] = state;
    data['updatedAt'] = updatedAt;
    return data;
  }
}