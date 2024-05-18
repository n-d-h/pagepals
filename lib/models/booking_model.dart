import 'book_models/book_model.dart';

class BookingModel {
  List<Booking>? list;
  Pagination? pagination;

  BookingModel({this.list, this.pagination});

  BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Booking>[];
      json['list'].forEach((v) {
        list!.add(new Booking.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Booking {
  String? id;
  int? rating;
  String? review;
  Meeting? meeting;
  Service? service;
  String? startAt;
  String? createAt;
  CustomerBooked? customer;
  String? cancelReason;
  BookingState? state;
  Event? event;

  Booking({
    this.id,
    this.rating,
    this.review,
    this.meeting,
    this.service,
    this.startAt,
    this.createAt,
    this.customer,
    this.cancelReason,
    this.state,
    this.event,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    meeting =
        json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    startAt = json['startAt'];
    createAt = json['createAt'];
    customer = json['customer'] != null
        ? new CustomerBooked.fromJson(json['customer'])
        : null;
    cancelReason = json['cancelReason'];
    state =
        json['state'] != null ? new BookingState.fromJson(json['state']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['review'] = this.review;
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['startAt'] = this.startAt;
    data['createAt'] = this.createAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['cancelReason'] = this.cancelReason;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    return data;
  }
}

class Event {
  String? id;
  bool? isFeatured;
  int? limitCustomer;
  int? price;
  String? startAt;
  int? activeSlot;
  Seminar? seminar;

  Event({
    this.id,
    this.isFeatured,
    this.limitCustomer,
    this.price,
    this.startAt,
    this.activeSlot,
    this.seminar,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFeatured = json['isFeatured'];
    limitCustomer = json['limitCustomer'];
    price = json['price'];
    startAt = json['startAt'];
    activeSlot = json['activeSlot'];
    seminar =
        json['seminar'] != null ? new Seminar.fromJson(json['seminar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFeatured'] = this.isFeatured;
    data['limitCustomer'] = this.limitCustomer;
    data['price'] = this.price;
    data['startAt'] = this.startAt;
    data['activeSlot'] = this.activeSlot;
    if (this.seminar != null) {
      data['seminar'] = this.seminar!.toJson();
    }
    return data;
  }
}

class Seminar {
  String? createdAt;
  String? description;
  int? duration;
  String? id;
  String? imageUrl;
  String? title;
  Book? book;
  Reader? reader;

  Seminar({
    this.createdAt,
    this.description,
    this.duration,
    this.id,
    this.imageUrl,
    this.title,
    this.book,
    this.reader,
  });

  Seminar.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    duration = json['duration'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    reader = json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    return data;
  }
}

class BookingState {
  String? name;

  BookingState({this.name});

  BookingState.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Meeting {
  String? meetingCode;
  String? password;
  String? id;

  Meeting({
    this.meetingCode,
    this.password,
    this.id,
  });

  Meeting.fromJson(Map<String, dynamic> json) {
    meetingCode = json['meetingCode'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meetingCode'] = this.meetingCode;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}

class Reader {
  String? id;
  String? nickname;
  String? avatarUrl;
  String? countryAccent;
  String? language;
  int? rating;
  int? totalOfReviews;
  Account? account;

  Reader({this.id, this.nickname, this.avatarUrl, this.account});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    countryAccent = json['countryAccent'];
    language = json['language'];
    rating = json['rating'];
    totalOfReviews = json['totalOfReviews'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    data['countryAccent'] = this.countryAccent;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['totalOfReviews'] = this.totalOfReviews;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Account {
  Customer? customer;
  String? username;

  Account({this.customer, this.username});

  Account.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['username'] = this.username;
    return data;
  }
}

class Customer {
  String? imageUrl;

  Customer({this.imageUrl});

  Customer.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Service {
  Book? book;
  double? duration;
  String? description;
  String? id;
  int? price;
  ServiceType? serviceType;
  Reader? reader;

  Service({
    this.book,
    this.duration,
    this.description,
    this.id,
    this.price,
    this.reader,
  });

  Service.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    duration = json['duration'];
    description = json['description'];
    id = json['id'];
    price = json['price'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
    reader = json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['id'] = this.id;
    data['price'] = this.price;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    return data;
  }
}

class CustomerBooked {
  String? id;
  String? imageUrl;
  String? fullName;
  String? gender;
  AccountBooked? account;

  CustomerBooked(
      {this.id, this.imageUrl, this.fullName, this.gender, this.account});

  CustomerBooked.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    fullName = json['fullName'];
    gender = json['gender'];
    account = json['account'] != null
        ? new AccountBooked.fromJson(json['account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class AccountBooked {
  String? username;
  String? email;
  String? phoneNumber;

  AccountBooked({this.username, this.email, this.phoneNumber});

  AccountBooked.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  String? sort;
  int? totalOfElements;
  int? totalOfPages;

  Pagination({
    this.currentPage,
    this.pageSize,
    this.sort,
    this.totalOfElements,
    this.totalOfPages,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    sort = json['sort'];
    totalOfElements = json['totalOfElements'];
    totalOfPages = json['totalOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['sort'] = this.sort;
    data['totalOfElements'] = this.totalOfElements;
    data['totalOfPages'] = this.totalOfPages;
    return data;
  }
}
