class ReaderProfile {
  Profile? profile;
  WorkingTimeList? workingTimeList;

  ReaderProfile({this.profile, this.workingTimeList});

  ReaderProfile.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    workingTimeList = json['workingTimeList'] != null
        ? new WorkingTimeList.fromJson(json['workingTimeList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.workingTimeList != null) {
      data['workingTimeList'] = this.workingTimeList!.toJson();
    }
    return data;
  }
}

class Profile {
  Account? account;
  String? nickname;
  String? audioDescriptionUrl;
  String? countryAccent;
  String? description;
  String? genre;
  String? id;
  String? introductionVideoUrl;
  String? language;
  int? rating;
  int? totalOfBookings;
  int? totalOfReviews;
  String? avatarUrl;
  String? createdAt;

  Profile(
      {this.account,
      this.nickname,
      this.audioDescriptionUrl,
      this.countryAccent,
      this.description,
      this.genre,
      this.id,
      this.introductionVideoUrl,
      this.language,
      this.rating,
      this.totalOfBookings,
      this.totalOfReviews,
      this.avatarUrl,
      this.createdAt});

  Profile.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    nickname = json['nickname'];
    audioDescriptionUrl = json['audioDescriptionUrl'];
    countryAccent = json['countryAccent'];
    description = json['description'];
    genre = json['genre'];
    id = json['id'];
    introductionVideoUrl = json['introductionVideoUrl'];
    language = json['language'];
    rating = json['rating'];
    totalOfBookings = json['totalOfBookings'];
    totalOfReviews = json['totalOfReviews'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['nickname'] = this.nickname;
    data['audioDescriptionUrl'] = this.audioDescriptionUrl;
    data['countryAccent'] = this.countryAccent;
    data['description'] = this.description;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['introductionVideoUrl'] = this.introductionVideoUrl;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['totalOfBookings'] = this.totalOfBookings;
    data['totalOfReviews'] = this.totalOfReviews;
    data['avatarUrl'] = this.avatarUrl;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Account {
  String? username;
  Customer? customer;
  String? email;
  String? phoneNumber;

  Account({this.username, this.customer, this.email, this.phoneNumber});

  Account.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Customer {
  String? imageUrl;
  String? dob;
  String? gender;

  Customer({this.imageUrl, this.dob, this.gender});

  Customer.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}

class WorkingTimeList {
  List<WorkingDates>? workingDates;

  WorkingTimeList({this.workingDates});

  WorkingTimeList.fromJson(Map<String, dynamic> json) {
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
  String? date;
  List<TimeSlots>? timeSlots;

  WorkingDates({this.date, this.timeSlots});

  WorkingDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(new TimeSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.timeSlots != null) {
      data['timeSlots'] = this.timeSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlots {
  String? startTime;

  TimeSlots({this.startTime});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    return data;
  }
}
