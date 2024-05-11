import 'package:pagepals/models/booking_model.dart';
import '../book_models/book_model.dart';

class Reader {
  String? id;
  String? introductionVideoUrl;
  String? thumbnailUrl;
  String? nickname;
  String? avatarUrl;
  String? countryAccent;
  int? rating;
  int? totalOfReviews;

  Reader({
    this.id,
    this.introductionVideoUrl,
    this.thumbnailUrl,
    this.nickname,
    this.avatarUrl,
    this.countryAccent,
    this.rating,
    this.totalOfReviews,
  });

  Reader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    introductionVideoUrl = json['introductionVideoUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    countryAccent = json['countryAccent'];
    rating = json['rating'];
    totalOfReviews = json['totalOfReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['introductionVideoUrl'] = introductionVideoUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    data['nickname'] = nickname;
    data['avatarUrl'] = avatarUrl;
    data['countryAccent'] = countryAccent;
    data['rating'] = rating;
    data['totalOfReviews'] = totalOfReviews;
    return data;
  }
}

class ServiceModel {
  Book? book;
  Reader? reader;
  String? id;
  double? duration;
  String? description;
  String? createdAt;
  String? imageUrl;
  int? price;
  int? rating;
  ServiceType? serviceType;
  String? status;
  int? totalOfBooking;
  int? totalOfReview;
  List<Booking>? bookings;

  ServiceModel({
    this.book,
    this.reader,
    this.id,
    this.duration,
    this.description,
    this.createdAt,
    this.imageUrl,
    this.price,
    this.rating,
    this.serviceType,
    this.status,
    this.totalOfBooking,
    this.totalOfReview,
    this.bookings,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? Book?.fromJson(json['book']) : null;
    reader = json['reader'] != null ? Reader?.fromJson(json['reader']) : null;
    id = json['id'];
    duration = json['duration'];
    description = json['description'];
    createdAt = json['createdAt'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    rating = json['rating'];
    serviceType = json['serviceType'] != null
        ? ServiceType?.fromJson(json['serviceType'])
        : null;
    status = json['status'];
    totalOfBooking = json['totalOfBooking'];
    totalOfReview = json['totalOfReview'];
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['book'] = book!.toJson();
    data['id'] = id;
    data['duration'] = duration;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['rating'] = rating;
    data['serviceType'] = serviceType!.toJson();
    data['status'] = status;
    data['totalOfBooking'] = totalOfBooking;
    data['totalOfReview'] = totalOfReview;
    data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    return data;
  }
}
