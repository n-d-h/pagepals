class BookModel {
  List<Books>? list;
  Paging? paging;

  BookModel({this.list, this.paging});

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Books>[];
      json['list'].forEach((v) {
        list!.add(new Books.fromJson(v));
      });
    }
    paging =
        json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class Books {
  Book? book;
  List<Services>? services;

  Books({this.book, this.services});

  Books.fromJson(Map<String, dynamic> json) {
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

  Book({
    this.id,
    this.title,
    this.publisher,
    this.language,
    this.authors,
    this.categories,
    this.description,
    this.pageCount,
    this.smallThumbnailUrl,
    this.thumbnailUrl,
  });

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
  String? shortDescription;
  int? totalOfBooking;
  int? totalOfReview;
  String? imageUrl;
  ServiceType? serviceType;

  Services({
    this.id,
    this.description,
    this.duration,
    this.price,
    this.rating,
    this.shortDescription,
    this.totalOfBooking,
    this.totalOfReview,
    this.imageUrl,
    this.serviceType,
  });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    rating = json['rating'];
    shortDescription = json['shortDescription'];
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
    imageUrl = json['imageUrl'];
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
    data['shortDescription'] = this.shortDescription;
    data['totalOfBooking'] = this.totalOfBooking;
    data['totalOfReview'] = this.totalOfReview;
    data['imageUrl'] = this.imageUrl;
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
