import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/list_request_model.dart';

class RequestService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<ListRequest>> getAllRequests(String readerId) async {
    String query = '''
      query {
        getListRequestByReaderId(readerId: "$readerId") {
          createdAt
          description
          id
          rejectReason
          staffName
          state
          updatedAt
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
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    List<ListRequest> listRequest = [];
    var data = queryResult.data!['getListRequestByReaderId'];
    for (var item in data) {
      listRequest.add(ListRequest.fromJson(item));
    }

    return listRequest;
  }
}
