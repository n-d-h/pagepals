class SearchReaderModel {
  List<Reader>? list;
  Pagination? pagination;

  SearchReaderModel({this.list, this.pagination});

  SearchReaderModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Reader>[];
      json['list'].forEach((v) {
        list!.add(new Reader.fromJson(v));
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

class Reader {
  String? audioDescriptionUrl;
  String? countryAccent;
  String? createdAt;
  String? description;
  String? genre;
  String? id;
  String? avatarUrl;
  String? introductionVideoUrl;
  String? language;
  String? nickname;
  int? rating;
  int? totalOfBookings;
  int? totalOfReviews;

  Reader(
      {this.audioDescriptionUrl,
        this.countryAccent,
        this.createdAt,
        this.description,
        this.genre,
        this.id,
        this.avatarUrl,
        this.introductionVideoUrl,
        this.language,
        this.nickname,
        this.rating,
        this.totalOfBookings,
        this.totalOfReviews});

  Reader.fromJson(Map<String, dynamic> json) {
    audioDescriptionUrl = json['audioDescriptionUrl'];
    countryAccent = json['countryAccent'];
    createdAt = json['createdAt'];
    description = json['description'];
    genre = json['genre'];
    id = json['id'];
    avatarUrl = json['avatarUrl'];
    introductionVideoUrl = json['introductionVideoUrl'];
    language = json['language'];
    nickname = json['nickname'];
    rating = json['rating'];
    totalOfBookings = json['totalOfBookings'];
    totalOfReviews = json['totalOfReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioDescriptionUrl'] = this.audioDescriptionUrl;
    data['countryAccent'] = this.countryAccent;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['avatarUrl'] = this.avatarUrl;
    data['introductionVideoUrl'] = this.introductionVideoUrl;
    data['language'] = this.language;
    data['nickname'] = this.nickname;
    data['rating'] = this.rating;
    data['totalOfBookings'] = this.totalOfBookings;
    data['totalOfReviews'] = this.totalOfReviews;
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
