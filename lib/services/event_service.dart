import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/event_model.dart';

class EventService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<EventModel> getAllEvent(int page, int pageSize) async {
    String query = '''
      query {
        getAllEvents(
          page: $page, 
          pageSize: $pageSize, 
          sort: "desc"
        ) {
          list {
            activeSlot
            createdAt
            id
            isFeatured
            limitCustomer
            price
            startAt
            state
            seminar {
              reader {
                id
                nickname
                avatarUrl
                thumbnailUrl
              }
              title
              description
              duration
              imageUrl
              createdAt
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

    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (queryResult.hasException) {
      throw Exception(queryResult.exception.toString());
    }

    var data = queryResult.data!['getAllEvents'];
    if(data == null) {
      throw Exception('No data found');
    }

    return EventModel.fromJson(data);
  }

  static Future<EventModel> getEventNotJoinByCustomer(
    int page, int pageSize, String customerId) async {
    String query = '''
      query {
        getAllEventsNotJoinByCustomer(
          customerId: "$customerId",
          page: $page, 
          pageSize: $pageSize, 
          sort: "desc"
        ) {
          list {
            activeSlot
            createdAt
            id
            isFeatured
            limitCustomer
            price
            startAt
            state
            seminar {
              reader {
                id
                nickname
                avatarUrl
                thumbnailUrl
              }
              title
              description
              duration
              imageUrl
              createdAt
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

    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (queryResult.hasException) {
      throw Exception(queryResult.exception.toString());
    }

    var data = queryResult.data!['getAllEventsNotJoinByCustomer'];
    if(data == null) {
      throw Exception('No data found');
    }

    return EventModel.fromJson(data);
  }
}
