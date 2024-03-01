import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/account_tokens.dart';
import 'package:pagepals/models/login_model.dart';

class AuthenService {
  static const String baseUrl = 'https://pagepals.azurewebsites.net/graphql';

  static Future<AccountTokens?> loginWithGoogle(String token) async {
    GraphQLClient graphQLClient = client!.value;
    var mutation = '''
    mutation {
      loginWithGoogle(token: "$token") {
        accessToken,
        refreshToken
      }
    }
    ''';

    return _authenWithGoogle(graphQLClient, mutation);
  }

  static Future<AccountTokens?> login(LoginModel loginModel) async {
    GraphQLClient graphQLClient = client!.value;
    var mutation = '''
    mutation {
      login(account: {username: "${loginModel.username}", password: "${loginModel.password}"}) {
        accessToken,
        refreshToken
      }
    }
    ''';

    return _authen(graphQLClient, mutation);
  }

  static Future<AccountTokens?> _authen(
      GraphQLClient client, String mutation) async {
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(mutation),
      ),
    );

    if (result.hasException) {
      throw Exception('Incorrect username or password');
    }

    var loginData = result.data?['login'];
    if (loginData != null) {
      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
      );
    }
  }

  static Future<AccountTokens?> _authenWithGoogle(
      GraphQLClient client, String mutation) async {
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(mutation),
      ),
    );

    if (result.hasException) {
      throw Exception('Incorrect username or password');
    }

    var loginData = result.data?['loginWithGoogle'];
    if (loginData != null) {
      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
      );
    }
  }
}
