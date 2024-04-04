class CustomerBook {
  List<Book>? list;
  Pagination? pagination;

  CustomerBook({this.list, this.pagination});

  CustomerBook.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Book>[];
      json['list'].forEach((v) {
        list!.add(new Book.fromJson(v));
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

class Book {
  List<Authors>? authors;
  List<Categories>? categories;
  String? description;
  String? externalId;
  String? id;
  String? language;
  int? pageCount;
  String? publishedDate;
  String? publisher;
  String? smallThumbnailUrl;
  String? thumbnailUrl;
  String? title;

  Book(
      {this.authors,
        this.categories,
        this.description,
        this.externalId,
        this.id,
        this.language,
        this.pageCount,
        this.publishedDate,
        this.publisher,
        this.smallThumbnailUrl,
        this.thumbnailUrl,
        this.title});

  Book.fromJson(Map<String, dynamic> json) {
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
    externalId = json['externalId'];
    id = json['id'];
    language = json['language'];
    pageCount = json['pageCount'];
    publishedDate = json['publishedDate'];
    publisher = json['publisher'];
    smallThumbnailUrl = json['smallThumbnailUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['externalId'] = this.externalId;
    data['id'] = this.id;
    data['language'] = this.language;
    data['pageCount'] = this.pageCount;
    data['publishedDate'] = this.publishedDate;
    data['publisher'] = this.publisher;
    data['smallThumbnailUrl'] = this.smallThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['title'] = this.title;
    return data;
  }
}

class Authors {
  String? id;
  String? name;

  Authors({this.id, this.name});

  Authors.fromJson(Map<String, dynamic> json) {
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

class Categories {
  String? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
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
