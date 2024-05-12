import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<bool> createBooking(String description, Services service,
      String timeSlotId, String promotionCode) async {
    // get customer id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;
    String accountJson = prefs.getString('account')!;
    AccountModel account = AccountModel.fromJson(json.decode(accountJson));
    String customerId = account.customer!.id!;

    var mutation = '''
      mutation {
        createBooking(
          booking: {
            description: "$description", 
            serviceId: "${service.id}", 
            totalPrice: ${service.price}, 
            workingTimeId: "$timeSlotId", 
            promotionCode: "$promotionCode"
          }
          customerId: "$customerId"
        ) {
          id
          meeting {
            meetingCode
          }
          workingTime {
            date
            startTime
          }
        }
      }
    ''';

    print(mutation);

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token').concat(
        graphQLClient.link,
      ),
      cache: graphQLClient.cache,
    );

    QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['createBooking'] != null;
  }

  static Future<BookingModel> getBooking(
      int page, int pageSize, String bookingState) async {
    // get customer id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;
    String accountJson = prefs.getString('account')!;
    AccountModel account = AccountModel.fromJson(json.decode(accountJson));
    String customerId = account.customer!.id!;

    String sort = 'desc';
    if (bookingState == 'PENDING') {
      sort = 'asc';
    }

    var query = '''
    query {
      getListBookingByCustomer(
        customerId: "$customerId"
        filter: {page: $page, pageSize: $pageSize, bookingState: "$bookingState", sort: "$sort"}
      ) {
        list {
          id
          rating
          review
          meeting {
            meetingCode
            password
            id
          }
          service {
            book {
              title
              smallThumbnailUrl
              thumbnailUrl
              id
            }
            duration
            description
            id
            price
            serviceType {
              id
              name
              description
            }
            reader {
              id
              nickname
              avatarUrl
              countryAccent
              language
              rating
              totalOfReviews
              account {
                customer {
                  imageUrl
                }
                username
              }
            }
          }
          startAt
          createAt
          customer {
            id
            imageUrl
            fullName
            gender
            account {
              username
              email
              phoneNumber
            }
          }
          cancelReason
          state {
            name
          }
          event {
            id
            isFeatured
            limitCustomer
            price
            startAt
            activeSlot
            seminar {
              createdAt
              description
              duration
              id
              imageUrl
              title
              book {
                id
                title
                publisher
                language
                authors {
                  name
                }
                categories {
                  name
                }
                description
                pageCount
                smallThumbnailUrl
                thumbnailUrl
              }
            }
          }
        }
        pagination {
          currentPage
          pageSize
          sort
          totalOfElements
          totalOfPages
        }
      }
    }
    ''';

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token').concat(
        graphQLClient.link,
      ),
      cache: graphQLClient.cache,
    );
    QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Error: ${result.exception}');
    }

    return BookingModel.fromJson(result.data!['getListBookingByCustomer']);
  }

  static Future<BookingModel> getBookingByReader(
      String readerId, int page, int pageSize, String bookingState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;
    print('accessToken: $token');

    String sort = 'desc';
    if (bookingState == 'PENDING') {
      sort = 'asc';
    }

    var query = '''
    query {
      getListBookingByReader(
        readerId: "$readerId"
        filter: {
          page: $page, 
          pageSize: $pageSize, 
          bookingState: "$bookingState", 
          sort: "$sort"
        }
      ) {
        list {
          id
          rating
          review
          meeting {
            meetingCode
            password
            id
          }
          service {
            book {
              title
              smallThumbnailUrl
              thumbnailUrl
              id
            }
            duration
            description
            id
            price
            serviceType {
              id
              name
              description
            }
          }
          startAt
          createAt
          customer {
            id
            imageUrl
            fullName
            gender
            account {
              username
              email
              phoneNumber
            }
          }
          cancelReason
          state {
            name
          }
          seminar {
            id
            imageUrl
            limitCustomer
            duration
            description
            createdAt
            price
            book {
              id
              smallThumbnailUrl
              thumbnailUrl
              title
            }
            startTime
            status
            title
            updatedAt
          }
        }
        pagination {
          currentPage
          pageSize
          sort
          totalOfElements
          totalOfPages
        }
      }
    }
    ''';

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token').concat(
        graphQLClient.link,
      ),
      cache: graphQLClient.cache,
    );

    QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to get booking');
    }

    return BookingModel.fromJson(result.data!['getListBookingByReader']);
  }

  static Future<bool> cancelBooking(String bookingId, String reason) async {
    var mutation = '''
      mutation {
        cancelBooking(bookingId: "$bookingId", reason: "$reason") {
          id
        }
      }
    ''';

    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['cancelBooking']?['id'] != null;
  }

  static Future<bool> completeBooking(String bookingId) async {
    var mutation = '''
      mutation {
        completeBooking(bookingId: "$bookingId") {
          id
        }
      }
    ''';

    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['completeBooking']?['id'] != null;
  }

  static Future<bool> reviewBooking(
      String bookingId, int rating, String review) async {
    var mutation = '''
      mutation {
        reviewBooking(
          bookingId: "$bookingId", 
          review: {
            rating: $rating,
            review: "$review"
          }
        ) {
          rating
        }
      }
    ''';

    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['reviewBooking']?['rating'] != null;
  }
}
