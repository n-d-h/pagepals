class Book {
  List<Category>? categories;
  List<Author>? authors;
  String? id;
  String? externalId;
  String? description;
  String? language;
  int? pageCount;
  String? publishedDate;
  String? publisher;
  String? smallThumbnailUrl;
  String? thumbnailUrl;
  String? title;

  Book({
    this.categories,
    this.authors,
    this.id,
    this.externalId,
    this.description,
    this.language,
    this.pageCount,
    this.publishedDate,
    this.publisher,
    this.smallThumbnailUrl,
    this.thumbnailUrl,
    this.title,
  });

  Book.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['authors'] != null) {
      authors = <Author>[];
      json['authors'].forEach((v) {
        authors!.add(Author.fromJson(v));
      });
    }
    id = json['id'];
    externalId = json['externalId'];
    description = json['description'];
    language = json['language'];
    pageCount = json['pageCount'];
    publishedDate = json['publishedDate'];
    publisher = json['publisher'];
    smallThumbnailUrl = json['smallThumbnailUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['categories'] = categories != null
        ? categories!.map((v) => v?.toJson()).toList()
        : null;
    data['authors'] =
        authors != null ? authors!.map((v) => v?.toJson()).toList() : null;
    data['id'] = id;
    data['externalId'] = externalId;
    data['description'] = description;
    data['language'] = language;
    data['pageCount'] = pageCount;
    data['publishedDate'] = publishedDate;
    data['publisher'] = publisher;
    data['smallThumbnailUrl'] = smallThumbnailUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    data['title'] = title;
    return data;
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Author {
  String? id;
  String? name;

  Author({this.id, this.name});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Meeting {
  String? meetingCode;
  String? password;
  int? limitOfPerson;
  String? id;

  Meeting({
    this.meetingCode,
    this.password,
    this.limitOfPerson,
    this.id,
  });

  Meeting.fromJson(Map<String, dynamic> json) {
    meetingCode = json['meetingCode'];
    password = json['password'];
    limitOfPerson = json['limitOfPerson'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['meetingCode'] = meetingCode;
    data['password'] = password;
    data['limitOfPerson'] = limitOfPerson;
    data['id'] = id;
    return data;
  }
}

class SeminarItem {
  int? activeSlot;
  String? createdAt;
  String? description;
  int? duration;
  String? id;
  String? imageUrl;
  int? limitCustomer;
  int? price;
  String? startTime;
  String? status;
  String? title;
  String? updatedAt;
  Reader? reader;
  Book? book;
  Meeting? meeting;

  SeminarItem({
    this.activeSlot,
    this.createdAt,
    this.description,
    this.duration,
    this.id,
    this.imageUrl,
    this.limitCustomer,
    this.price,
    this.startTime,
    this.status,
    this.title,
    this.updatedAt,
    this.reader,
    this.book,
    this.meeting,
  });

  SeminarItem.fromJson(Map<String, dynamic> json) {
    activeSlot = json['activeSlot'];
    createdAt = json['createdAt'];
    description = json['description'];
    duration = json['duration'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    limitCustomer = json['limitCustomer'];
    price = json['price'];
    startTime = json['startTime'];
    status = json['status'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
    book = json['book'] != null ? Book?.fromJson(json['book']) : null;
    meeting =
        json['meeting'] != null ? Meeting?.fromJson(json['meeting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['activeSlot'] = activeSlot;
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['duration'] = duration;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['limitCustomer'] = limitCustomer;
    data['price'] = price;
    data['startTime'] = startTime;
    data['status'] = status;
    data['title'] = title;
    data['updatedAt'] = updatedAt;
    data['reader'] = reader!.toJson();
    data['book'] = book!.toJson();
    data['meeting'] = meeting!.toJson();
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

  Reader({this.id, this.nickname, this.avatarUrl});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nickname'] = nickname;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}

class SeminarModel {
  List<SeminarItem>? list;
  Pagination? pagination;

  SeminarModel({this.list, this.pagination});

  SeminarModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SeminarItem>[];
      json['list'].forEach((v) {
        list!.add(SeminarItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination?.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['list'] = list != null ? list!.map((v) => v?.toJson()).toList() : null;
    data['pagination'] = pagination!.toJson();
    return data;
  }
}
