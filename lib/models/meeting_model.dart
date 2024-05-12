class MeetingItem {
  String? accountId;
  String? downloadAccessToken;
  int? duration;
  String? hostEmail;
  String? hostId;
  String? id;
  String? password;
  int? recordingCount;
  List<RecordingFile>? recordingFiles;
  String? recordingPlayPasscode;
  String? shareUrl;
  String? startTime;
  String? timezone;
  String? topic;
  int? totalSize;
  int? type;
  String? uuid;

  MeetingItem({
    this.accountId,
    this.downloadAccessToken,
    this.duration,
    this.hostEmail,
    this.hostId,
    this.id,
    this.password,
    this.recordingCount,
    this.recordingFiles,
    this.recordingPlayPasscode,
    this.shareUrl,
    this.startTime,
    this.timezone,
    this.topic,
    this.totalSize,
    this.type,
    this.uuid,
  });

  MeetingItem.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    downloadAccessToken = json['download_access_token'];
    duration = json['duration'];
    hostEmail = json['host_email'];
    hostId = json['host_id'];
    id = json['id'];
    password = json['password'];
    recordingCount = json['recording_count'];
    if (json['recording_files'] != null) {
      recordingFiles = <RecordingFile>[];
      json['recording_files'].forEach((v) {
        recordingFiles!.add(RecordingFile.fromJson(v));
      });
    }
    recordingPlayPasscode = json['recording_play_passcode'];
    shareUrl = json['share_url'];
    startTime = json['start_time'];
    timezone = json['timezone'];
    topic = json['topic'];
    totalSize = json['total_size'];
    type = json['type'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['account_id'] = accountId;
    data['download_access_token'] = downloadAccessToken;
    data['duration'] = duration;
    data['host_email'] = hostEmail;
    data['host_id'] = hostId;
    data['id'] = id;
    data['password'] = password;
    data['recording_count'] = recordingCount;
    data['recording_files'] = recordingFiles != null
        ? recordingFiles!.map((v) => v.toJson()).toList()
        : null;
    data['recording_play_passcode'] = recordingPlayPasscode;
    data['share_url'] = shareUrl;
    data['start_time'] = startTime;
    data['timezone'] = timezone;
    data['topic'] = topic;
    data['total_size'] = totalSize;
    data['type'] = type;
    data['uuid'] = uuid;
    return data;
  }
}

class RecordingFile {
  String? downloadUrl;
  String? fileExtension;
  int? fileSize;
  String? fileType;
  String? id;
  String? meetingId;
  String? playUrl;
  String? recordingEnd;
  String? recordingStart;
  String? recordingType;
  String? status;

  RecordingFile({
    this.downloadUrl,
    this.fileExtension,
    this.fileSize,
    this.fileType,
    this.id,
    this.meetingId,
    this.playUrl,
    this.recordingEnd,
    this.recordingStart,
    this.recordingType,
    this.status,
  });

  RecordingFile.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['download_url'];
    fileExtension = json['file_extension'];
    fileSize = json['file_size'];
    fileType = json['file_type'];
    id = json['id'];
    meetingId = json['meeting_id'];
    playUrl = json['play_url'];
    recordingEnd = json['recording_end'];
    recordingStart = json['recording_start'];
    recordingType = json['recording_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['download_url'] = downloadUrl;
    data['file_extension'] = fileExtension;
    data['file_size'] = fileSize;
    data['file_type'] = fileType;
    data['id'] = id;
    data['meeting_id'] = meetingId;
    data['play_url'] = playUrl;
    data['recording_end'] = recordingEnd;
    data['recording_start'] = recordingStart;
    data['recording_type'] = recordingType;
    data['status'] = status;
    return data;
  }
}

class MeetingModel {
  String? from;
  String? nextPageToken;
  int? pageCount;
  int? pageSize;
  String? to;
  int? totalRecords;
  List<MeetingItem>? meetings;

  MeetingModel({
    this.from,
    this.nextPageToken,
    this.pageCount,
    this.pageSize,
    this.to,
    this.totalRecords,
    this.meetings,
  });

  MeetingModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    nextPageToken = json['next_page_token'];
    pageCount = json['page_count'];
    pageSize = json['page_size'];
    to = json['to'];
    totalRecords = json['total_records'];
    if (json['meetings'] != null) {
      meetings = <MeetingItem>[];
      json['meetings'].forEach((v) {
        meetings!.add(MeetingItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['from'] = from;
    data['next_page_token'] = nextPageToken;
    data['page_count'] = pageCount;
    data['page_size'] = pageSize;
    data['to'] = to;
    data['total_records'] = totalRecords;
    data['meetings'] =
        meetings != null ? meetings!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
