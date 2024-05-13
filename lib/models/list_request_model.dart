class ListRequest {
  String? createdAt;
  String? description;
  String? id;
  String? rejectReason;
  String? staffName;
  String? state;
  String? updatedAt;

  ListRequest({
    this.createdAt,
    this.description,
    this.id,
    this.rejectReason,
    this.staffName,
    this.state,
    this.updatedAt,
  });

  ListRequest.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    id = json['id'];
    rejectReason = json['rejectReason'];
    staffName = json['staffName'];
    state = json['state'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['rejectReason'] = rejectReason;
    data['staffName'] = staffName;
    data['state'] = state;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
