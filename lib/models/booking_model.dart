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
  Meeting? meeting;
  Service? service;
  String? startAt;

  Booking({this.meeting, this.service, this.startAt});

  Booking.fromJson(Map<String, dynamic> json) {
    meeting =
        json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    startAt = json['startAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['startAt'] = this.startAt;
    return data;
  }
}

class Meeting {
  Reader? reader;
  String? meetingCode;

  Meeting({this.reader, this.meetingCode});

  Meeting.fromJson(Map<String, dynamic> json) {
    reader =
        json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
    meetingCode = json['meetingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    data['meetingCode'] = this.meetingCode;
    return data;
  }
}

class Reader {
  String? nickname;
  Account? account;

  Reader({this.nickname, this.account});

  Reader.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
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

  Service({this.book, this.duration, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    data['duration'] = this.duration;
    data['description'] = this.description;
    return data;
  }
}

class Book {
  String? title;
  String? smallThumbnailUrl;
  String? thumbnailUrl;

  Book({this.title, this.smallThumbnailUrl, this.thumbnailUrl});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    smallThumbnailUrl = json['smallThumbnailUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['smallThumbnailUrl'] = this.smallThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  String? sort;
  int? totalOfElements;
  int? totalOfPages;

  Pagination(
      {this.currentPage,
      this.pageSize,
      this.sort,
      this.totalOfElements,
      this.totalOfPages});

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
