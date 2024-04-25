class WithdrawItem {
  double? amount;
  String? bankAccountName;
  String? bankAccountNumber;
  String? bankName;
  String? createdAt;
  String? id;
  Reader? reader;
  String? rejectReason;
  String? staffId;
  String? staffName;
  String? state;
  String? transactionImage;
  String? updatedAt;

  WithdrawItem({
    this.amount,
    this.bankAccountName,
    this.bankAccountNumber,
    this.bankName,
    this.createdAt,
    this.id,
    this.reader,
    this.rejectReason,
    this.staffId,
    this.staffName,
    this.state,
    this.transactionImage,
    this.updatedAt,
  });

  WithdrawItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    bankAccountName = json['bankAccountName'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    createdAt = json['createdAt'];
    id = json['id'];
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
    rejectReason = json['rejectReason'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    state = json['state'];
    transactionImage = json['transactionImage'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['amount'] = amount;
    data['bankAccountName'] = bankAccountName;
    data['bankAccountNumber'] = bankAccountNumber;
    data['bankName'] = bankName;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['reader'] = reader!.toJson();
    data['rejectReason'] = rejectReason;
    data['staffId'] = staffId;
    data['staffName'] = staffName;
    data['state'] = state;
    data['transactionImage'] = transactionImage;
    data['updatedAt'] = updatedAt;
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
  String? avatarUrl;

  Reader({this.id, this.nickname, this.avatarUrl});

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nickname'] = nickname;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}

class WithdrawModel {
  List<WithdrawItem>? list;
  Paging? paging;

  WithdrawModel({this.list, this.paging});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <WithdrawItem>[];
      json['list'].forEach((v) {
        list!.add(WithdrawItem.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging?.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['list'] = list != null ? list!.map((v) => v.toJson()).toList() : null;
    data['paging'] = paging!.toJson();
    return data;
  }
}
