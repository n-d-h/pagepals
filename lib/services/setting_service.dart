import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/setting_model.dart';

class SettingsService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<Map<String, String>> getAllSettings() async {
    String query = '''
      query {
        getAllSettings {
          id
          key
          value
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
      throw Exception(result.exception.toString());
    }

    final List<SettingModel> settings = (result.data!['getAllSettings'] as List)
        .map((setting) => SettingModel.fromJson(setting))
        .toList();

    final Map<String, String> settingsMap = {};
    settings.forEach((setting) {
      settingsMap[setting.key!] = setting.value!;
    });

    return settingsMap;
  }
}
