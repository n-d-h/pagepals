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

class Book {
  List<Category?>? categories;
  List<Author?>? authors;
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

  Book({this.categories, this.authors, this.id, this.externalId, this.description, this.language, this.pageCount, this.publishedDate, this.publisher, this.smallThumbnailUrl, this.thumbnailUrl, this.title});

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
    data['categories'] =categories != null ? categories!.map((v) => v?.toJson()).toList() : null;
    data['authors'] =authors != null ? authors!.map((v) => v?.toJson()).toList() : null;
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

class ServiceModel {
  Book? book;
  String? id;
  double? duration;
  String? description;
  String? createdAt;
  double? price;
  int? rating;
  ServiceType? serviceType;
  String? status;
  int? totalOfBooking;
  int? totalOfReview;

  ServiceModel({this.book, this.id, this.duration, this.description, this.createdAt, this.price, this.rating, this.serviceType, this.status, this.totalOfBooking, this.totalOfReview});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? Book?.fromJson(json['book']) : null;
    id = json['id'];
    duration = json['duration'];
    description = json['description'];
    createdAt = json['createdAt'];
    price = json['price'];
    rating = json['rating'];
    serviceType = json['serviceType'] != null ? ServiceType?.fromJson(json['serviceType']) : null;
    status = json['status'];
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['book'] = book!.toJson();
    data['id'] = id;
    data['duration'] = duration;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['price'] = price;
    data['rating'] = rating;
    data['serviceType'] = serviceType!.toJson();
    data['status'] = status;
    data['totalOfBooking'] = totalOfBooking;
    data['totalOfReview'] = totalOfReview;
    return data;
  }
}

class ServiceType {
  String? id;
  String? name;

  ServiceType({this.id, this.name});

  ServiceType.fromJson(Map<String, dynamic> json) {
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

