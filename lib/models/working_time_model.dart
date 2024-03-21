class WorkingTimeModel {
  List<WorkingDates>? workingDates;

  WorkingTimeModel({this.workingDates});

  WorkingTimeModel.fromJson(Map<String, dynamic> json) {
    if (json['workingDates'] != null) {
      workingDates = <WorkingDates>[];
      json['workingDates'].forEach((v) {
        workingDates!.add(new WorkingDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workingDates != null) {
      data['workingDates'] = this.workingDates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkingDates {
  List<TimeSlots>? timeSlots;
  String? date;

  WorkingDates({this.timeSlots, this.date});

  WorkingDates.fromJson(Map<String, dynamic> json) {
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(new TimeSlots.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeSlots != null) {
      data['timeSlots'] = this.timeSlots!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class TimeSlots {
  String? id;
  String? startTime;

  TimeSlots({this.id, this.startTime});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    return data;
  }
}
