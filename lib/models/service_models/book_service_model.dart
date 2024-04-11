class BookServiceModel {
  List<Services>? services;
  Paging? paging;

  BookServiceModel({this.services, this.paging});

  BookServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
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

class Services {
  String? id;
  String? description;
  double? duration;
  int? price;
  int? rating;
  Reader? reader;
  int? totalOfBooking;
  int? totalOfReview;

  Services(
      {this.id,
      this.description,
      this.duration,
      this.price,
      this.rating,
      this.reader,
      this.totalOfBooking,
      this.totalOfReview});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    rating = json['rating'];
    reader =
        json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['rating'] = this.rating;
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    data['totalOfBooking'] = this.totalOfBooking;
    data['totalOfReview'] = this.totalOfReview;
    return data;
  }
}

class Reader {
  String? id;
  String? nickname;
  String? avatarUrl;
  String? language;

  Reader({this.id, this.nickname, this.avatarUrl, this.language});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    data['language'] = this.language;
    return data;
  }
}

class Paging {
  int? currentPage;
  int? pageSize;
  String? sort;
  int? totalOfElements;
  int? totalOfPages;

  Paging(
      {this.currentPage,
      this.pageSize,
      this.sort,
      this.totalOfElements,
      this.totalOfPages});

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
