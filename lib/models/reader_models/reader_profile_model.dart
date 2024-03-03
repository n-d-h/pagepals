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
  double? experience;
  String? genre;
  String? id;
  String? introductionVideoUrl;
  String? language;
  int? rating;
  String? tags;
  String? totalOfBookings;
  String? totalOfReviews;
  List<Services>? services;

  Profile(
      {this.account,
        this.nickname,
        this.audioDescriptionUrl,
        this.countryAccent,
        this.description,
        this.experience,
        this.genre,
        this.id,
        this.introductionVideoUrl,
        this.language,
        this.rating,
        this.tags,
        this.totalOfBookings,
        this.totalOfReviews,
        this.services});

  Profile.fromJson(Map<String, dynamic> json) {
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    nickname = json['nickname'];
    audioDescriptionUrl = json['audioDescriptionUrl'];
    countryAccent = json['countryAccent'];
    description = json['description'];
    experience = json['experience'];
    genre = json['genre'];
    id = json['id'];
    introductionVideoUrl = json['introductionVideoUrl'];
    language = json['language'];
    rating = json['rating'];
    tags = json['tags'];
    totalOfBookings = json['totalOfBookings'];
    totalOfReviews = json['totalOfReviews'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
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
    data['experience'] = this.experience;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['introductionVideoUrl'] = this.introductionVideoUrl;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['tags'] = this.tags;
    data['totalOfBookings'] = this.totalOfBookings;
    data['totalOfReviews'] = this.totalOfReviews;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  String? username;

  Account({this.username});

  Account.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}

class Services {
  List<BookingDetails>? bookingDetails;
  Chapter? chapter;

  Services({this.bookingDetails, this.chapter});

  Services.fromJson(Map<String, dynamic> json) {
    if (json['bookingDetails'] != null) {
      bookingDetails = <BookingDetails>[];
      json['bookingDetails'].forEach((v) {
        bookingDetails!.add(new BookingDetails.fromJson(v));
      });
    }
    chapter =
    json['chapter'] != null ? new Chapter.fromJson(json['chapter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingDetails != null) {
      data['bookingDetails'] =
          this.bookingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.toJson();
    }
    return data;
  }
}

class BookingDetails {
  Null? rating;
  Null? review;
  String? description;
  Booking? booking;

  BookingDetails({this.rating, this.review, this.description, this.booking});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    review = json['review'];
    description = json['description'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['description'] = this.description;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  Customer? customer;

  Booking({this.customer});

  Booking.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  Account? account;

  Customer({this.account});

  Customer.fromJson(Map<String, dynamic> json) {
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Chapter {
  Book? book;

  Chapter({this.book});

  Chapter.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    return data;
  }
}

class Book {
  String? title;

  Book({this.title});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
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
