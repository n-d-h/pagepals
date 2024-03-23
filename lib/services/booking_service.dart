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

    QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      GraphQLClient clientWithToken = GraphQLClient(
        link: AuthLink(getToken: () async => 'Bearer $token').concat(
          graphQLClient.link,
        ),
        cache: graphQLClient.cache,
      );
      result = await clientWithToken.query(
        QueryOptions(
          document: gql(mutation),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );
      if (result.hasException) {
        return false;
      }
      // throw Exception('Failed to create booking');
    }
    return result.data?['createBooking'] != null;
  }

  static Future<BookingModel> getBooking(int page, int pageSize) async {
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
        filter: {page: 0, pageSize: 10}
      ) {
        list {
          meeting {
            reader {
              nickname
              account {
                customer {
                  imageUrl
                }
                username
              }
            }
            meetingCode
          }
          service {
            book {
              title
              smallThumbnailUrl
              thumbnailUrl
            }
            duration
            description
          }
          startAt
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

    QueryResult result;

    result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      GraphQLClient clientWithToken = GraphQLClient(
        link: AuthLink(getToken: () async => 'Bearer $token').concat(
          graphQLClient.link,
        ),
        cache: graphQLClient.cache,
      );
      result = await clientWithToken.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );
      if (result.hasException) {
        throw Exception('Failed to get booking');
      }
    }

    return BookingModel.fromJson(result.data!['getListBookingByCustomer']);
  }
}