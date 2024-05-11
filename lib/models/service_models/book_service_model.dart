import 'package:pagepals/models/book_models/book_model.dart';

class BookServiceModel {
  List<BookServices>? services;
  Paging? paging;

  BookServiceModel({this.services, this.paging});

  BookServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <BookServices>[];
      json['services'].forEach((v) {
        services!.add(new BookServices.fromJson(v));
      });
    }
    paging =
        json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class BookServices {
  String? id;
  String? description;
  double? duration;
  int? price;
  int? rating;
  int? totalOfBooking;
  int? totalOfReview;
  String? imageUrl;
  Reader? reader;
  Book? book;
  ServiceType? serviceType;

  BookServices({
    this.id,
    this.description,
    this.duration,
    this.price,
    this.rating,
    this.totalOfBooking,
    this.totalOfReview,
    this.imageUrl,
    this.reader,
    this.book,
    this.serviceType,
  });

  BookServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    rating = json['rating'];
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
    imageUrl = json['imageUrl'];
    reader =
        json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['totalOfBooking'] = this.totalOfBooking;
    data['totalOfReview'] = this.totalOfReview;
    data['imageUrl'] = this.imageUrl;
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    return data;
  }
}

class Reader {
  String? id;
  String? nickname;
  String? avatarUrl;
  String? language;
  String? countryAccent;

  Reader({
    this.id,
    this.nickname,
    this.avatarUrl,
    this.language,
    this.countryAccent,
  });

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    language = json['language'];
    countryAccent = json['countryAccent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    data['language'] = this.language;
    data['countryAccent'] = this.countryAccent;
    return data;
  }
}

class Paging {
  int? currentPage;
  int? pageSize;
  String? sort;
  int? totalOfElements;
  int? totalOfPages;

  Paging({
    this.currentPage,
    this.pageSize,
    this.sort,
    this.totalOfElements,
    this.totalOfPages,
  });

  Paging.fromJson(Map<String, dynamic> json) {
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
