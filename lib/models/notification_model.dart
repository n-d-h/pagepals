class Account {
  String? id;
  Customer? customer;
  Reader? reader;

  Account({this.id, this.customer, this.reader});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer?.fromJson(json['customer']) : null;
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['customer'] = customer!.toJson();
    data['reader'] = reader!.toJson();
    return data;
  }
}

class Customer {
  String? id;
  String? fullName;

  Customer({this.id, this.fullName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['fullName'] = fullName;
    return data;
  }
}

class NotificationItem {
  String? content;
  String? createdAt;
  String? id;
  bool? isRead;
  String? status;
  String? updatedAt;
  Account? account;

  NotificationItem(
      {this.content,
      this.createdAt,
      this.id,
      this.isRead,
      this.status,
      this.updatedAt,
      this.account});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = json['createdAt'];
    id = json['id'];
    isRead = json['isRead'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    account =
        json['account'] != null ? Account?.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['isRead'] = isRead;
    data['status'] = status;
    data['updatedAt'] = updatedAt;
    data['account'] = account!.toJson();
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
  String? id;
  String? nickname;

  Reader({this.id, this.nickname});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nickname'] = nickname;
    return data;
  }
}

class NotificationModel {
  List<NotificationItem>? list;
  Pagination? pagination;
  int? total;

  NotificationModel({this.list, this.pagination, this.total});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <NotificationItem>[];
      json['list'].forEach((v) {
        list!.add(NotificationItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination?.fromJson(json['pagination'])
        : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['list'] = list != null ? list!.map((v) => v?.toJson()).toList() : null;
    data['pagination'] = pagination!.toJson();
    data['total'] = total;
    return data;
  }
}
