import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/service_model.dart';

class ServiceService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<ServiceModel>> getListServiceByReader(
      String readerId) async {
    String query = '''
      query serviceByReader {
        getServicesByReader(
          readerId: "$readerId",
          filter: {page: 0, pageSize: 10, search: "", sort: ""}
        ) {
          paging {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
          services {
            book {
              categories {
                id
                name
              }
              authors {
                id
                name
              }
              id
              externalId
              description
              language
              pageCount
              publishedDate
              publisher
              smallThumbnailUrl
              thumbnailUrl
              title
            }
            id
            duration
            description
            createdAt
            price
            rating
            serviceType {
              id
              name
            }
            status
            totalOfBooking
            totalOfReview
          }
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
      throw Exception('Failed to get list service by reader');
    }

    final servicesData = result.data?['getServicesByReader']['services'];
    return servicesData
        .map<ServiceModel>((service) => ServiceModel.fromJson(service))
        .toList();
  }
}