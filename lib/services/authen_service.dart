import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/models/authen_models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<AccountTokens?> loginWithGoogle(String token) async {
    var mutation = '''
    mutation {
      loginWithGoogle(token: "$token") {
        accessToken,
        refreshToken
      }
    }
    ''';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final QueryResult result = await graphQLClient.query(
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

      // save account
      String username = user.payload['username'];
      AccountModel account = await getAccount(username);
      print('account: ${json.encoder.convert(account)}');
      prefs.setString('account', json.encoder.convert(account));

      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
      );
    }
  }

  static Future<AccountTokens?> login(LoginModel loginModel) async {
    var mutation = '''
    mutation {
      login(account: {username: "${loginModel.username}", password: "${loginModel.password}"}) {
        accessToken,
        refreshToken
      }
    }
    ''';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
      ),
    );

    if (result.hasException) {
      throw Exception('Incorrect username or password');
    }

    var loginData = result.data?['login'];
    if (loginData != null) {
      final user = JWT.decode(loginData?['accessToken']);
      prefs.setString('accessToken', loginData?['accessToken']);
      prefs.setString('refreshToken', loginData?['refreshToken']);

      // save account
      String username = user.payload['username'];
      AccountModel account = await getAccount(username);
      prefs.setString('account', json.encoder.convert(account));

      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
      );
    }
  }

  static Future<AccountModel> getAccount(String username) async {
    String query = '''
        query {
          getAccountByUsername(username: "$username") {
            id
            username
            fullName
            phoneNumber
            email
            customer {
              id
              imageUrl
              dob
              gender
            }
            reader {
              id
            }
          }
        }
    ''';
    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to load account');
    }

    final accountData = result.data?['getAccountByUsername'];
    return AccountModel.fromJson(accountData);
  }
}
