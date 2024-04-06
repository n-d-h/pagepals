class AccountModel {
  String? id;
  String? username;
  String? fullName;
  String? phoneNumber;
  String? email;
  Customer? customer;
  Reader? reader;
  AccountState? accountState;

  AccountModel({
    this.id,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.customer,
    this.reader,
    this.accountState,
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
