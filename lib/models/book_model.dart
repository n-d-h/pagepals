class BookModel {
  String? id;
  String? title;
  String? publisher;
  String? language;
  List<BookAuthors>? bookAuthors;
  List<BookCategories>? bookCategories;
  String? description;
  int? pageCount;
  String? smallThumbnailUrl;
  String? thumbnailUrl;

  BookModel(
      {this.id,
      this.title,
      this.publisher,
      this.language,
      this.bookAuthors,
      this.bookCategories,
      this.description,
      this.pageCount,
      this.smallThumbnailUrl,
      this.thumbnailUrl});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publisher = json['publisher'];
    language = json['language'];
    if (json['bookAuthors'] != null) {
      bookAuthors = <BookAuthors>[];
      json['bookAuthors'].forEach((v) {
        bookAuthors!.add(new BookAuthors.fromJson(v));
      });
    }
    if (json['bookCategories'] != null) {
      bookCategories = <BookCategories>[];
      json['bookCategories'].forEach((v) {
        bookCategories!.add(new BookCategories.fromJson(v));
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
    if (this.bookAuthors != null) {
      data['bookAuthors'] = this.bookAuthors!.map((v) => v.toJson()).toList();
    }
    if (this.bookCategories != null) {
      data['bookCategories'] =
          this.bookCategories!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['pageCount'] = this.pageCount;
    data['smallThumbnailUrl'] = this.smallThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class BookAuthors {
  String? name;

  BookAuthors({this.name});

  BookAuthors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class BookCategories {
  String? name;

  BookCategories({this.name});

  BookCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
