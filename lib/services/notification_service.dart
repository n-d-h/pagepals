import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/notification_model.dart';

class NotificationService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<NotificationModel> getAllNotificationByAccountId(
      String accountId, int page, int pageSize) async {
    var query = '''
      query MyQuery {
        getAllNotificationsByAccountId(
          accountId: "$accountId"
          page: $page
          pageSize: $pageSize
          sort: "desc"
          notificationRole: READER
        ) {
          list {
            content
            createdAt
            id
            isRead
            status
            updatedAt
            account {
              id
              customer {
                id
                fullName
              }
              reader {
                id
                nickname
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
          total
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data =
        result.data?['getAllNotificationsByAccountId'];
    if (data == null) {
      throw Exception('No data found');
    }

    return NotificationModel.fromJson(data);
  }

  static Future<NotificationItem> getNotificationById(String id) async {
    var query = '''
      query MyQuery {
        getNotificationById(id: "$id") {
          content
          createdAt
          id
          isRead
          status
          updatedAt
          account {
            id
            customer {
              id
              fullName
            }
            reader {
              id
              nickname
            }
          }
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data = result.data?['getNotificationById'];
    if (data == null) {
      throw Exception('No data found');
    }

    return NotificationItem.fromJson(data);
  }

  static Future<NotificationItem> updateReadNotification(String id) async {
    var mutation = '''
      mutation MyMutation {
        readNotification(id: "$id") {
          content
          createdAt
          id
          isRead
          status
          updatedAt
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(mutation),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data = result.data?['readNotification'];
    if (data == null) {
      throw Exception('No data found');
    }

    return NotificationItem.fromJson(data);
  }

  static Future<void> readAllNotificationByAccountId(String accountId) async {
    var mutation = '''
      mutation MyMutation {
        readAllNotifications(accountId: "$accountId") {
          content
          createdAt
          id
          isRead
          status
          updatedAt
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(mutation),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<Object?>? data = result.data?['readAllNotifications'];
    if (data == null) {
      throw Exception('No data found');
    }
  }
}
