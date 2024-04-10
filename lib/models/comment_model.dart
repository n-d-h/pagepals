class Customer {
  String? fullName;
  String? imageUrl;

  Customer({this.fullName, this.imageUrl});

  Customer.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fullName'] = fullName;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class CommentItem {
  String? date;
  int? rating;
  String? review;
  Customer? customer;

  CommentItem({this.date, this.rating, this.review, this.customer});

  CommentItem.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    rating = json['rating'];
    review = json['review'];
    customer = json['customer'] != null ? Customer?.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['rating'] = rating;
    data['review'] = review;
    data['customer'] = customer!.toJson();
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  String? sort;
  int? totalOfElements;
  int? totalOfPages;

  Pagination({this.currentPage, this.pageSize, this.sort, this.totalOfElements, this.totalOfPages});

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

class CommentModel {
  List<CommentItem>? list;
  Pagination? pagination;

  CommentModel({this.list, this.pagination});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommentItem>[];
      json['list'].forEach((v) {
        list!.add(CommentItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination?.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['list'] =list != null ? list!.map((v) => v.toJson()).toList() : null;
    data['pagination'] = pagination!.toJson();
    return data;
  }
}