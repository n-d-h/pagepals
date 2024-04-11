import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_models/book_model.dart';

class ServiceTypeService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<ServiceType>> getListServiceTypesByService(
      List<String> serviceIds) async {
    String query = '''
      query {
        getListServiceTypesByService(
        services: [
            ${serviceIds.map((serviceId) => '"$serviceId"').join(',')}
            ]
        ) {
          id
          name
          description
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
      throw Exception('Failed to get list service types by service');
    }

    final List<dynamic> serviceTypesData =
        result.data?['getListServiceTypesByService'];
    return serviceTypesData
        .map<ServiceType>((serviceType) => ServiceType.fromJson(serviceType))
        .toList();
  }
}
