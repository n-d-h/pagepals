class PopularReader {
  String? language;
  int? rating;
  String? countryAccent;
  String? description;
  double? experience;
  String? genre;
  String? id;
  String? nickname;
  List<Services>? services;
  String? introductionVideoUrl;
  String? totalOfReviews;
  Account? account;

  PopularReader(
      {this.language,
        this.rating,
        this.countryAccent,
        this.description,
        this.experience,
        this.genre,
        this.id,
        this.nickname,
        this.services,
        this.introductionVideoUrl,
        this.totalOfReviews,
        this.account});

  PopularReader.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    rating = json['rating'];
    countryAccent = json['countryAccent'];
    description = json['description'];
    experience = json['experience'];
    genre = json['genre'];
    id = json['id'];
    nickname = json['nickname'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    introductionVideoUrl = json['introductionVideoUrl'];
    totalOfReviews = json['totalOfReviews'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['countryAccent'] = this.countryAccent;
    data['description'] = this.description;
    data['experience'] = this.experience;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['introductionVideoUrl'] = this.introductionVideoUrl;
    data['totalOfReviews'] = this.totalOfReviews;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Services {
  double? price;
  int? totalOfReview;

  Services({this.price, this.totalOfReview});

  Services.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    totalOfReview = json['totalOfReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['totalOfReview'] = this.totalOfReview;
    return data;
  }
}

class Account {
  Customer? customer;

  Account({this.customer});

  Account.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? imageUrl;

  Customer({this.imageUrl});

  Customer.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
