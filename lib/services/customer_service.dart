import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/auth_service.dart';

class CustomerService {
  static Future<Customer> updateCustomer(String customerId, String dob,
      String fullName, String gender, String imageUrl) async {
    String mutation = '''
      mutation MyMutation {
        updateCustomer(
          id: "$customerId"
          customer: {
            fullName: "$fullName",
            gender: $gender,
            dob: "$dob",
            imageUrl: "$imageUrl"
          }
        ) {
          id
          imageUrl
          fullName
          dob
          gender
        }
      }
    ''';

    final GraphQLClient clientWithToken =
        await AuthService.getGraphQLClientWithToken();

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to update customer');
    }

    final customerData = result.data?['updateCustomer'];
    return Customer.fromJson(customerData);
  }
}