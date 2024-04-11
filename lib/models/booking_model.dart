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

  Booking(
      {this.id,
      this.rating,
      this.review,
      this.meeting,
      this.service,
      this.startAt,
      this.createAt,
      this.customer});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    meeting =
        json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    startAt = json['startAt'];
    createAt = json['createdAt'];
    customer = json['customer'] != null
        ? new CustomerBooked.fromJson(json['customer'])
        : null;
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
    data['createdAt'] = this.createAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Meeting {
  Reader? reader;
  String? meetingCode;
  int? limitOfPerson;
  String? id;

  Meeting({this.reader, this.meetingCode, this.limitOfPerson, this.id});

  Meeting.fromJson(Map<String, dynamic> json) {
    reader =
        json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
    meetingCode = json['meetingCode'];
    limitOfPerson = json['limitOfPerson'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    data['meetingCode'] = this.meetingCode;
    data['limitOfPerson'] = this.limitOfPerson;
    data['id'] = this.id;
    return data;
  }
}

class Reader {
  String? id;
  String? nickname;
  String? avatarUrl;
  Account? account;

  Reader({this.id, this.nickname, this.avatarUrl, this.account});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
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

  Service({this.book, this.duration, this.description, this.id, this.price});

  Service.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    duration = json['duration'];
    description = json['description'];
    id = json['id'];
    price = json['price'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
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
    return data;
  }
}

class ServiceType {
  String? id;
  String? name;
  String? description;

  ServiceType({this.id, this.name, this.description});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Book {
  String? title;
  String? smallThumbnailUrl;
  String? thumbnailUrl;
  String? id;

  Book({this.title, this.smallThumbnailUrl, this.thumbnailUrl, this.id});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    smallThumbnailUrl = json['smallThumbnailUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['smallThumbnailUrl'] = this.smallThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['id'] = this.id;
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
