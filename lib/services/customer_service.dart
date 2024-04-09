import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/customer_transaction_model.dart';
import 'package:pagepals/services/auth_service.dart';

class CustomerService {
  static GraphQLClient graphQLClient = client!.value;

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

  static Future<CustomerTransactionModel> getCustomerTransaction(
      String customerId,
      int page,
      int pageSize,
      String startDate,
      String endDate,
      String transactionType) async {
    String query = '''
      query {
        getListTransactionForCustomer(
          customerId: "$customerId",
          filter: {
            endDate: "$endDate", 
            page: $page, 
            pageSize: $pageSize, 
            startDate: "$startDate", 
            transactionType:"$transactionType"}
        ) {
          list {
            amount
            createAt
            currency
            description
            id
            status
            transactionType
          }
          paging {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to get customer transaction');
    }

    final transactionData = result.data?['getListTransactionForCustomer'];
    return CustomerTransactionModel.fromJson(transactionData);
  }
}