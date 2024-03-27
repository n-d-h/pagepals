class GoogleBookModel {
  String? id;
  VolumeInfo? volumeInfo;

  GoogleBookModel({this.id, this.volumeInfo});

  GoogleBookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volumeInfo = json['volumeInfo'] != null
        ? new VolumeInfo.fromJson(json['volumeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo!.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  List<String>? authors;
  List<String>? categories;
  String? description;
  ImageLinks? imageLinks;
  String? language;
  int? pageCount;
  String? publishedDate;
  String? publisher;
  String? title;

  VolumeInfo(
      {this.authors,
      this.categories,
      this.description,
      this.imageLinks,
      this.language,
      this.pageCount,
      this.publishedDate,
      this.publisher,
      this.title});

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    authors = json['authors'] != null ? List<String>.from(json['authors']) : null;
    categories = json['categories'] != null ? List<String>.from(json['categories']) : null;
    description = json['description'];
    imageLinks = json['imageLinks'] != null ? ImageLinks.fromJson(json['imageLinks']) : null;
    language = json['language'];
    pageCount = json['pageCount'];
    publishedDate = json['publishedDate'];
    publisher = json['publisher'];
    title = json['title'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authors'] = this.authors;
    data['categories'] = this.categories;
    data['description'] = this.description;
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.toJson();
    }
    data['language'] = this.language;
    data['pageCount'] = this.pageCount;
    data['publishedDate'] = this.publishedDate;
    data['publisher'] = this.publisher;
    data['title'] = this.title;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
