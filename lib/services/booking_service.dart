import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_model.dart';
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
    mutation MyMutation {
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
    // throw Exception('Failed to create booking');

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

    var query = '''
    query {
      getListBookingByCustomer(
        customerId: "$customerId"
        filter: {page: $page, pageSize: $pageSize, bookingState: "$bookingState"}
      ) {
        list {
          id
          meeting {
            reader {
              id
              nickname
              account {
                customer {
                  imageUrl
                }
                username
              }
            }
            meetingCode
            limitOfPerson
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
          }
          startAt
          createdAt
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

    return BookingModel.fromJson(result.data!['getListBookingByCustomer']);
  }

  static Future<BookingModel> getBookingByReader(
      String readerId, int page, int pageSize, String bookingState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;
    print('accessToken: $token');

    var query = '''
    query {
      getListBookingByReader(
        readerId: "$readerId"
        filter: {page: $page, pageSize: $pageSize, bookingState: "$bookingState"}
      ) {
        list {
          id
          meeting {
            reader {
              id
              nickname
              account {
                customer {
                  imageUrl
                }
                username
              }
            }
            meetingCode
            limitOfPerson
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
          }
          startAt
          createdAt
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
}
