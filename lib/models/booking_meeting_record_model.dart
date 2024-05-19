class Meeting {
  String? createAt;
  String? id;
  String? meetingCode;
  String? password;
  String? startAt;
  String? state;
  List<Record>? records;

  Meeting({
    this.createAt,
    this.id,
    this.meetingCode,
    this.password,
    this.startAt,
    this.state,
    this.records,
  });

  Meeting.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    id = json['id'];
    meetingCode = json['meetingCode'];
    password = json['password'];
    startAt = json['startAt'];
    state = json['state'];
    if (json['records'] != null) {
      records = <Record>[];
      json['records'].forEach((v) {
        records!.add(Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createAt'] = createAt;
    data['id'] = id;
    data['meetingCode'] = meetingCode;
    data['password'] = password;
    data['startAt'] = startAt;
    data['state'] = state;
    data['records'] =
        records != null ? records!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class Record {
  int? duration;
  String? externalId;
  String? id;
  int? recordingCount;
  String? startTime;
  String? status;
  List<RecordFile>? recordFiles;

  Record({
    this.duration,
    this.externalId,
    this.id,
    this.recordingCount,
    this.startTime,
    this.status,
    this.recordFiles,
  });

  Record.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    externalId = json['externalId'];
    id = json['id'];
    recordingCount = json['recordingCount'];
    startTime = json['startTime'];
    status = json['status'];
    if (json['recordFiles'] != null) {
      recordFiles = <RecordFile>[];
      json['recordFiles'].forEach((v) {
        recordFiles!.add(RecordFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['duration'] = duration;
    data['externalId'] = externalId;
    data['id'] = id;
    data['recordingCount'] = recordingCount;
    data['startTime'] = startTime;
    data['status'] = status;
    data['recordFiles'] = recordFiles != null
        ? recordFiles!.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}

class RecordFile {
  String? downloadUrl;
  String? endAt;
  String? fileExtention;
  String? fileType;
  String? id;
  String? playUrl;
  String? recordingType;
  String? startAt;
  String? status;

  RecordFile({
    this.downloadUrl,
    this.endAt,
    this.fileExtention,
    this.fileType,
    this.id,
    this.playUrl,
    this.recordingType,
    this.startAt,
    this.status,
  });

  RecordFile.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['downloadUrl'];
    endAt = json['endAt'];
    fileExtention = json['fileExtention'];
    fileType = json['fileType'];
    id = json['id'];
    playUrl = json['playUrl'];
    recordingType = json['recordingType'];
    startAt = json['startAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['downloadUrl'] = downloadUrl;
    data['endAt'] = endAt;
    data['fileExtention'] = fileExtention;
    data['fileType'] = fileType;
    data['id'] = id;
    data['playUrl'] = playUrl;
    data['recordingType'] = recordingType;
    data['startAt'] = startAt;
    data['status'] = status;
    return data;
  }
}

class BookingMeetingRecordModel {
  String? id;
  Meeting? meeting;

  BookingMeetingRecordModel({this.id, this.meeting});

  BookingMeetingRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meeting =
        json['meeting'] != null ? Meeting?.fromJson(json['meeting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['meeting'] = meeting!.toJson();
    return data;
  }
}
