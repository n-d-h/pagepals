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
        fetchPolicy: FetchPolicy.noCache,
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

  static Future<bool> bookEvent(String customerId, String eventId) async {
    String mutation = '''
      mutation MyMutation {
        bookEvent(customerId: "$customerId", eventId: "$eventId") {
          booking {
            id
          }
          event {
            id
          }
        }
      }
    ''';

    QueryResult queryResult = await graphQLClient.mutate(
      MutationOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (queryResult.hasException) {
      throw Exception(queryResult.exception.toString());
    }

    return queryResult.data!['bookEvent']['booking']['id'] != null;
  }
}
