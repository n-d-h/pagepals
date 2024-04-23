import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';

class ReportService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<bool> createReport(
    String customerId,
    String reason,
    String reportedId,
    String type,
  ) async {
    var mutation = '''
      mutation MyMutation {
        createReport(
          input: {
            customerId: "$customerId", 
            reason: "$reason", 
            reportedId: "$reportedId", 
            type: $type
          }) {
          id
        }
      }
    ''';

    final QueryResult result = await graphQLClient.mutate(
      MutationOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var data = result.data?['createReport'];
    if (data == null) {
      throw Exception('No data found');
    }

    return data['id'] != null;
  }
}
