class BookModel {
  Book? book;
  List<Services>? services;

  BookModel({this.book, this.services});

  BookModel.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  String? id;
  String? title;
  String? publisher;
  String? language;
  List<Authors>? authors;
  List<Categories>? categories;
  String? description;
  int? pageCount;
  String? smallThumbnailUrl;
  String? thumbnailUrl;

  Book(
      {this.id,
        this.title,
        this.publisher,
        this.language,
        this.authors,
        this.categories,
        this.description,
        this.pageCount,
        this.smallThumbnailUrl,
        this.thumbnailUrl});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publisher = json['publisher'];
    language = json['language'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(new Authors.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    description = json['description'];
    pageCount = json['pageCount'];
    smallThumbnailUrl = json['smallThumbnailUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['publisher'] = this.publisher;
    data['language'] = this.language;
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['pageCount'] = this.pageCount;
    data['smallThumbnailUrl'] = this.smallThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class Authors {
  String? name;

  Authors({this.name});

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Services {
  String? id;
  String? description;
  double? duration;
  int? price;
  int? rating;
  int? totalOfBooking;
  int? totalOfReview;
  ServiceType? serviceType;

  Services(
      {this.id,
        this.description,
        this.duration,
        this.price,
        this.rating,
        this.totalOfBooking,
        this.totalOfReview,
        this.serviceType});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    rating = json['rating'];
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
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
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
