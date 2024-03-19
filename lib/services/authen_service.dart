import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/models/authen_models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
      final user = JWT.decode(loginData?['accessToken']);
      prefs.setString('accessToken', loginData?['accessToken']);
      prefs.setString('refreshToken', loginData?['refreshToken']);
      prefs.setString('username', user.payload['username']);

      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
      );
    }
  }
}
