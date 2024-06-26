import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/models/authen_models/login_model.dart';
import 'package:pagepals/models/zoom_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
        fetchPolicy: FetchPolicy.networkOnly,
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
      AccountModel account =
          await getAccount(username, loginData?['accessToken']);
      print('account: ${json.encoder.convert(account)}');
      print('account: ${loginData?['accessToken']}');
      prefs.setString('account', json.encoder.convert(account));

      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
        accountId: account.id,
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
        fetchPolicy: FetchPolicy.networkOnly,
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
      AccountModel account =
          await getAccount(username, loginData?['accessToken']);
      prefs.setString('account', json.encoder.convert(account));
      print('account: ${json.encoder.convert(account)}');

      return AccountTokens(
        accessToken: loginData?['accessToken'],
        refreshToken: loginData?['refreshToken'],
        accountId: account.id,
      );
    }
  }

  static Future<AccountModel> getAccount(String username, String token) async {
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
              fullName
            }
            reader {
              id
              nickname
              avatarUrl
            }
            accountState {
              name
              id
            }
            wallet {
              id
              cash
              tokenAmount
            }
          }
        }
    ''';
    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token').concat(
        graphQLClient.link,
      ),
      cache: graphQLClient.cache,
    );
    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to load account');
    }

    final accountData = result.data?['getAccountByUsername'];
    return AccountModel.fromJson(accountData);
  }

  static Future<String> verifyEmailRegister(String email) async {
    var mutation = '''
    mutation {
      verifyEmailRegister(
        register: {username: "$email", password: "", email: "$email"}
      )
    }
    ''';

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to refresh token');
    }

    var otpCode = result.data?['verifyEmailRegister'];
    if (otpCode != null) {
      // return code from backend
      String encodedCode = otpCode.toString();
      // set SECRET_KEY
      String SECRET_KEY = "jkHGs0lbxWwbirSG";

      // Convert the encoded code to bytes
      Uint8List encodedBytes =
          Uint8List.fromList(encrypt.Encrypted.fromBase64(encodedCode).bytes);

      // Convert the secret key to bytes
      Uint8List keyBytes = Uint8List.fromList(SECRET_KEY.codeUnits);

      // Create an instance of AES cipher
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key(keyBytes),
          mode: encrypt.AESMode.ecb, // Use ECB mode
          padding: "PKCS7", // Use PKCS7 padding
        ),
      );

      // Decrypt the bytes
      final decryptedBytes =
          encrypter.decryptBytes(encrypt.Encrypted(encodedBytes));

      // Convert decrypted bytes to string
      final decodedCode = String.fromCharCodes(decryptedBytes);

      return decodedCode;
    }
    return '';
  }

  static Future<bool> registerCustomer(
      String username, String password, String email) async {
    var mutation = '''
      mutation register {
        register(register: {username: "$username", password: "$password", email: "$email"}) {
          accessToken
          refreshToken
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
      throw Exception('Failed to register');
    }

    var registerData = result.data?['register'];
    if (registerData != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', registerData?['accessToken']);
      prefs.setString('refreshToken', registerData?['refreshToken']);

      // save account
      AccountModel account =
          await getAccount(username, registerData?['accessToken']);
      prefs.setString('account', json.encoder.convert(account));

      return true;
    }

    return false;
  }

  static Future<void> updateAccountToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    String accessToken = prefs.getString('accessToken')!;
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      AccountModel account =
          AccountModel.fromJson(json.decoder.convert(accountString));
      String userName = account.username!;

      AccountModel updatedAccount =
          await AuthenService.getAccount(userName, accessToken);
      prefs.remove('account');
      print('account: ${json.encode(updatedAccount)}');
      prefs.setString('account', json.encode(updatedAccount));
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

  static Future<AccountModel?> updateAndGetNewAccountFromSharePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    String accessToken = prefs.getString('accessToken')!;
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return null;
    }
    try {
      AccountModel account =
          AccountModel.fromJson(json.decoder.convert(accountString));
      String userName = account.username!;

      AccountModel updatedAccount =
          await AuthenService.getAccount(userName, accessToken);
      prefs.remove('account');
      prefs.setString('account', json.encode(updatedAccount));
      return updatedAccount;
    } catch (e) {
      print('Error decoding account data: $e');
      return null;
    }
  }

  static Future<AccountModel?> getAccountFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return null;
    }
    try {
      AccountModel account =
          AccountModel.fromJson(json.decoder.convert(accountString));
      return account;
    } catch (e) {
      print('Error decoding account data: $e');
      return null;
    }
  }

  static Future<void> updateFcmToken(
      String fcmToken, String id, bool isWebToken) async {
    var mutation = '''
      mutation MyMutation {
        updateFcmToken(
          fcmToken: "$fcmToken", 
          id: "$id", 
          isWebToken: $isWebToken
        ) {
          createdAt
          deletedAt
          email
          fullName
          id
          password
          phoneNumber
          updatedAt
          username
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
      throw Exception('Failed to update FCM token');
    }

    print('FCM token updated');
    var data = result.data?['updateFcmToken'];
    if (data != null) {
      print('FCM token updated: ${json.encode(data)}');
    }
  }

  static Future<String> getZoomAuth() async {
    String query = '''
      query MyQuery {
        getAuthZoom {
          access_token
          expires_in
          scope
          token_type
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to get Zoom auth');
    }

    var data = result.data?['getAuthZoom'];
    if (data != null) {
      String accessToken = ZoomAuth.fromJson(data).accesstoken ?? '';
      var url = Uri.parse('https://api.zoom.us/v2/users/me/token?type=zak');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${accessToken}',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['token'];
      } else {
        throw Exception('Failed to get Zoom token');
      }
    }
    return '';
  }

  static Future<void> updateAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    String accessToken = prefs.getString('accessToken')!;
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      AccountModel account =
          AccountModel.fromJson(json.decoder.convert(accountString));
      String userName = account.username!;

      AccountModel updatedAccount =
          await AuthenService.getAccount(userName, accessToken);
      prefs.remove('account');
      print('account: ${json.encode(updatedAccount)}');
      prefs.setString('account', json.encode(updatedAccount));
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }
}
