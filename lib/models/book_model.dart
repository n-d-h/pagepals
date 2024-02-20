class BookModel {
  String? id;
  String? title;
  String? longTitle;
  String? author;
  String? publisher;
  int? pages;
  String? language;
  String? overview;
  String? imageUrl;
  String? edition;
  String? status;
  String? createdAt;
  Category? category;
  List<Chapters>? chapters;

  BookModel(
      {this.id,
        this.title,
        this.longTitle,
        this.author,
        this.publisher,
        this.pages,
        this.language,
        this.overview,
        this.imageUrl,
        this.edition,
        this.status,
        this.createdAt,
        this.category,
        this.chapters});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    longTitle = json['longTitle'];
    author = json['author'];
    publisher = json['publisher'];
    pages = json['pages'];
    language = json['language'];
    overview = json['overview'];
    imageUrl = json['imageUrl'];
    edition = json['edition'];
    status = json['status'];
    createdAt = json['createdAt'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['longTitle'] = this.longTitle;
    data['author'] = this.author;
    data['publisher'] = this.publisher;
    data['pages'] = this.pages;
    data['language'] = this.language;
    data['overview'] = this.overview;
    data['imageUrl'] = this.imageUrl;
    data['edition'] = this.edition;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? description;

  Category({this.id, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json) {
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

class Chapters {
  String? id;
  int? chapterNumber;
  int? pages;

  Chapters({this.id, this.chapterNumber, this.pages});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chapterNumber = json['chapterNumber'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chapterNumber'] = this.chapterNumber;
    data['pages'] = this.pages;
    return data;
  }
}