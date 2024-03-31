import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<GraphQLClient> getGraphQLClientWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token').concat(
        graphQLClient.link,
      ),
      cache: graphQLClient.cache,
    );

    return clientWithToken;
  }
}