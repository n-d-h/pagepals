import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/momo_response_model.dart';

class MoMoService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<MoMoResponseModel> getMoMoResponse(
      int? amount, String? customerId) async {
    var mutation = '''
      mutation MyMutation {
        createOrderMobile(amount: $amount, customerId: "$customerId") {
          message
          payUrl
          resultCode
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to load MoMo response');
    }

    print(result.data?['createOrderMobile']);

    return MoMoResponseModel.fromJson(result.data?['createOrderMobile']);
  }
}
