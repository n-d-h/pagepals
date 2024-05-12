import 'book_models/book_model.dart';

class EventItemModel {
  int? activeSlot;
  String? createdAt;
  String? id;
  bool? isFeatured;
  int? limitCustomer;
  int? price;
  String? startAt;
  String? state;
  Seminar? seminar;

  EventItemModel({
    this.activeSlot,
    this.createdAt,
    this.id,
    this.isFeatured,
    this.limitCustomer,
    this.price,
    this.startAt,
    this.state,
    this.seminar,
  });

  EventItemModel.fromJson(Map<String, dynamic> json) {
    activeSlot = json['activeSlot'];
    createdAt = json['createdAt'];
    id = json['id'];
    isFeatured = json['isFeatured'];
    limitCustomer = json['limitCustomer'];
    price = json['price'];
    startAt = json['startAt'];
    state = json['state'];
    seminar =
        json['seminar'] != null ? Seminar?.fromJson(json['seminar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['activeSlot'] = activeSlot;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['isFeatured'] = isFeatured;
    data['limitCustomer'] = limitCustomer;
    data['price'] = price;
    data['startAt'] = startAt;
    data['state'] = state;
    data['seminar'] = seminar!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['sort'] = sort;
    data['totalOfElements'] = totalOfElements;
    data['totalOfPages'] = totalOfPages;
    return data;
  }
}

class Reader {
  String? id;
  String? nickname;
  String? avatarUrl;
  String? thumbnailUrl;

  Reader({this.id, this.nickname, this.avatarUrl, this.thumbnailUrl});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nickname'] = nickname;
    data['avatarUrl'] = avatarUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}

class Seminar {
  Reader? reader;
  Book? book;
  String? title;
  String? description;
  int? duration;
  String? imageUrl;
  String? createdAt;

  Seminar({
    this.reader,
    this.book,
    this.title,
    this.description,
    this.duration,
    this.imageUrl,
    this.createdAt,
  });

  Seminar.fromJson(Map<String, dynamic> json) {
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
    book = json['book'] != null ? Book?.fromJson(json['book']) : null;
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['reader'] = reader!.toJson();
    data['book'] = book!.toJson();
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}

class EventModel {
  List<EventItemModel>? list;
  Pagination? pagination;

  EventModel({this.list, this.pagination});

  EventModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <EventItemModel>[];
      json['list'].forEach((v) {
        list!.add(EventItemModel.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination?.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['list'] = list != null ? list!.map((v) => v.toJson()).toList() : null;
    data['pagination'] = pagination!.toJson();
    return data;
  }
}
