import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/seminar_model.dart';

class SeminarService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<SeminarModel> getAllSeminars(
      int page, int pageSize) async {
    String query = '''
      query MyQuery {
        getAllSeminars(page: $page, pageSize: $pageSize, sort: "desc") {
          list {
            activeSlot
            createdAt
            description
            duration
            id
            imageUrl
            limitCustomer
            price
            startTime
            status
            title
            updatedAt
            reader {
              id
              nickname
              avatarUrl
            }
            book {
              id
              thumbnailUrl
              title
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

    QueryResult queryResult = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (queryResult.hasException) {
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    var data = queryResult.data!['getAllSeminars'];
    if (data == null) {
      throw Exception('Error: No data found');
    }

    return SeminarModel.fromJson(data);
  }
}
