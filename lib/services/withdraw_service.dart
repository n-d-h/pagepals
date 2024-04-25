import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/withdraw_model.dart';

class WithDrawService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<WithdrawModel> getWithdrawByReaderId(
    int page,
    int pageSize,
    String sort,
    String readerId,
  ) async {
    String query = '''
      query MyQuery {
        withdrawRequestsByReaderId(
          query: {page: $page, pageSize: $pageSize, sort: "desc"}
          readerId: "$readerId"
        ) {
          list {
            amount
            bankAccountName
            bankAccountNumber
            bankName
            createdAt
            id
            reader {
              id
              nickname
              avatarUrl
            }
            rejectReason
            staffId
            staffName
            state
            transactionImage
            updatedAt
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
      throw Exception(result.exception.toString());
    }

    var results = result.data!['withdrawRequestsByReaderId'];
    if (results == null) {
      return WithdrawModel(
        list: [],
        paging: null
      );
    }

    return WithdrawModel.fromJson(results);
  }

  static Future<bool> createWithdrawRequest(
    String readerId,
    String bankAccountName,
    String bankAccountNumber,
    String bankName,
    double amount,
  ) async {
    String query = '''
      mutation MyMutation {
        createWithdrawRequest(
          input: {
            amount: $amount,
            bankAccountName: "$bankAccountName", 
            bankAccountNumber: "$bankAccountNumber", 
            bankName: "$bankName",
          }
          readerId: "$readerId"
        ) {
          amount
          bankAccountName
          bankAccountNumber
          bankName
          createdAt
          id
          rejectReason
          staffId
          staffName
          state
          transactionImage
          updatedAt
          reader {
            id
            nickname
            avatarUrl
          }
        }
      }
    ''';
    final QueryResult result = await graphQLClient.mutate(MutationOptions(
      document: gql(query),
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var results = result.data!['createWithdrawRequest'];
    return results['id'] != null;
  }
}
