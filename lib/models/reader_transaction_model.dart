class TransactionModel {
  double? amount;
  String? createAt;
  String? currency;
  String? description;
  String? id;
  String? status;
  String? transactionType;

  TransactionModel(
      {this.amount,
        this.createAt,
        this.currency,
        this.description,
        this.id,
        this.status,
        this.transactionType});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createAt = json['createAt'];
    currency = json['currency'];
    description = json['description'];
    id = json['id'];
    status = json['status'];
    transactionType = json['transactionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['amount'] = amount;
    data['createAt'] = createAt;
    data['currency'] = currency;
    data['description'] = description;
    data['id'] = id;
    data['status'] = status;
    data['transactionType'] = transactionType;
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

class ReaderTransactionModel {
  List<TransactionModel>? list = <TransactionModel>[];
  Paging? paging;

  ReaderTransactionModel({this.list, this.paging});

  ReaderTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      json['list'].forEach((v) {
        list?.add(TransactionModel.fromJson(v));
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
