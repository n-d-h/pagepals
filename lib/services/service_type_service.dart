import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_models/book_model.dart';

class ServiceTypeService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<ServiceType>> getListServiceTypesByServicesOfReaderBook(
      String bookId, String readerId) async {
    String query = '''
      query {
        getListServiceTypesByServicesOfReaderBook(
          bookId: "$bookId"
          readerId: "$readerId"
        ) {
          id
          name
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
        result.data?['getListServiceTypesByServicesOfReaderBook'];
    return serviceTypesData
        .map<ServiceType>((serviceType) => ServiceType.fromJson(serviceType))
        .toList();
  }

  static Future<List<Services>> getListServiceByServiceTypeAndBookAndReader(
      String readerId, String bookId, String serviceTypeId) async {
    String query = '''
      query {
        getListServiceByServiceTypeAndBookAndReader(
          bookId: "$bookId"
          readerId: "$readerId"
          serviceTypeId: "$serviceTypeId"
        ) {
          id
          description
          duration
          price
          rating
          totalOfBooking
          totalOfReview
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

    final List<dynamic> servicesData =
        result.data?['getListServiceByServiceTypeAndBookAndReader'];
    return servicesData
        .map<Services>((service) => Services.fromJson(service))
        .toList();
  }
}
