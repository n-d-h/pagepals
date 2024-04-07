class AccountModel {
  String? id;
  String? username;
  String? fullName;
  String? phoneNumber;
  String? email;
  Customer? customer;
  Reader? reader;
  AccountState? accountState;
  Wallet? wallet;

  AccountModel({
    this.id,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.customer,
    this.reader,
    this.accountState,
    this.wallet,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    reader =
        json['reader'] != null ? new Reader.fromJson(json['reader']) : null;
    accountState = json['accountState'] != null
        ? new AccountState.fromJson(json['accountState'])
        : null;
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.reader != null) {
      data['reader'] = this.reader!.toJson();
    }
    if (this.accountState != null) {
      data['accountState'] = this.accountState!.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? imageUrl;
  String? fullName;
  String? dob;
  String? gender;

  Customer({this.id, this.imageUrl, this.dob, this.gender, this.fullName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    dob = json['dob'];
    gender = json['gender'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['fullName'] = this.fullName;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    return data;
  }
}

class AccountState {
  String? name;
  String? id;

  AccountState({this.name, this.id});

  AccountState.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Wallet {
  String? id;
  double? cash;
  int? tokenAmount;
  List<Transaction?>? transactions;

  Wallet({this.id, this.cash, this.tokenAmount, this.transactions});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cash = json['cash'];
    tokenAmount = json['tokenAmount'];
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['cash'] = cash;
    data['tokenAmount'] = tokenAmount;
    data['transactions'] = transactions != null
        ? transactions!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}

class Transaction {
  double? amount;
  String? transactionType;
  String? status;
  String? id;
  String? description;
  String? currency;
  String? createAt;

  Transaction(
      {this.amount,
      this.transactionType,
      this.status,
      this.id,
      this.description,
      this.currency,
      this.createAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    transactionType = json['transactionType'];
    status = json['status'];
    id = json['id'];
    description = json['description'];
    currency = json['currency'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['amount'] = amount;
    data['transactionType'] = transactionType;
    data['status'] = status;
    data['id'] = id;
    data['description'] = description;
    data['currency'] = currency;
    data['createAt'] = createAt;
    return data;
  }
}
