class AccountModel {
  String? id;
  String? username;
  String? fullName;
  String? phoneNumber;
  String? email;
  Customer? customer;
  Reader? reader;

  AccountModel(
      {this.id,
      this.username,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.customer,
      this.reader});

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
    return data;
  }
}

class Customer {
  String? id;
  String? imageUrl;
  String? dob;
  String? gender;

  Customer({this.id, this.imageUrl, this.dob, this.gender});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
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
