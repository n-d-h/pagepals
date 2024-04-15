import 'dart:core';

class PostItemModel {
  String? content;
  String? id;
  String? createdAt;
  List<String>? postImages;
  Reader? reader;
  String? title;

  PostItemModel(
      {this.content,
      this.id,
      this.createdAt,
      this.postImages,
      this.reader,
      this.title});

  PostItemModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    createdAt = json['createdAt'];
    if (json['postImages'] != null) {
      postImages = <String>[];
      json['postImages'].forEach((v) {
        postImages!.add(v);
      });
    }
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['postImages'] = postImages != null ? postImages : null;
    data['reader'] = reader!.toJson();
    data['title'] = title;
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
  String? avatarUrl;
  String? id;
  String? nickname;

  Reader({this.avatarUrl, this.id, this.nickname});

  Reader.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    id = json['id'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['avatarUrl'] = avatarUrl;
    data['id'] = id;
    data['nickname'] = nickname;
    return data;
  }
}

class PostModel {
  List<PostItemModel>? list;
  Pagination? pagination;

  PostModel({this.list, this.pagination});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <PostItemModel>[];
      json['list'].forEach((v) {
        list!.add(PostItemModel.fromJson(v));
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
