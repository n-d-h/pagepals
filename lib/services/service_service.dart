import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/models/service_models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/book_models/book_model.dart';

class ServiceService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<ServiceModel>> getListServiceByReader(
      String readerId, int page, int pageSize, String search) async {
    String query = '''
      query serviceByReader {
        getServicesByReader(
          readerId: "$readerId",
          filter: {page: $page, pageSize: $pageSize, search: "$search", sort: "desc"}
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
            reader {
              id
              introductionVideoUrl
              thumbnailUrl
              nickname
              avatarUrl
              countryAccent
            }
            id
            duration
            description
            createdAt
            imageUrl
            price
            rating
            sortDescription
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
    var list = servicesData
        .map<ServiceModel>((service) => ServiceModel.fromJson(service))
        .toList();
    return list.isEmpty ? [ServiceModel()] : list;
  }

  static Future<List<ServiceType>> getListServiceType() async {
    String query = '''
      query {
        getListServiceType {
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
      throw Exception('Failed to get list service type');
    }

    final List<dynamic> serviceTypesData = result.data?['getListServiceType'];
    return serviceTypesData
        .map<ServiceType>((serviceType) => ServiceType.fromJson(serviceType))
        .toList();
  }

  static Future<bool> createService(
      String readerId,
      String serviceTypeId,
      GoogleBookModel book,
      String description,
      double price,
      double duration) async {
    String mutation = '''
      mutation {
        createService(
          service: {
            readerId: "$readerId", 
            serviceTypeId: "$serviceTypeId", 
            book: {
              id: "${book.id}", 
              volumeInfo: {
                authors: "${book.volumeInfo!.authors!.join(',')}", 
                categories: "${book.volumeInfo!.categories!.join(',')}", 
                description: "${book.volumeInfo!.description}", 
                imageLinks: {
                  smallThumbnail: "${book.volumeInfo!.imageLinks!.smallThumbnail}", 
                  thumbnail: "${book.volumeInfo!.imageLinks!.thumbnail}"
                }, 
                language: "${book.volumeInfo!.language}", 
                pageCount: ${book.volumeInfo!.pageCount}, 
                publishedDate: "${book.volumeInfo!.publishedDate}", 
                publisher: "${book.volumeInfo!.publisher}", 
                title: "${book.volumeInfo!.title}"
              }
            }, 
            description: "$description", 
            duration: $duration, 
            price: $price
          }
        ) {
          id
        }
      }
    ''';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to create service');
    }

    return result.data?['createService']?['id'] != null;
  }

  static Future<bool> updateService(
    String serviceId,
    String serviceTypeId,
    String description,
    double price,
  ) async {
    String mutation = '''
      mutation {
        updateService(
          id: "$serviceId", 
          service: {
            description: "$description", 
            price: $price, 
            serviceTypeId: "$serviceTypeId",
          }
        ) {
          id
        }
      }
    ''';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['updateService']?['id'] != null;
  }

  static Future<bool> keepBookingAndUpdateService(
      String serviceId,
      String serviceTypeId,
      String description,
      double price,
      ) async {
    String mutation = '''
      mutation {
        keepBookingAndUpdateService(
          id: "$serviceId", 
          service: {
            description: "$description", 
            price: $price, 
            serviceTypeId: "$serviceTypeId",
          }
        ) {
          id
        }
      }
    ''';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to update service');
    }

    return result.data?['keepBookingAndUpdateService']?['id'] != null;
  }

  static Future<bool> deleteService(String serviceId) async {
    String mutation = '''
      mutation {
        deleteService(id: "$serviceId")
      }
    ''';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return false;
    }

    return result.data?['deleteService'] != null;
  }

  static Future<bool> keepBookingAndDeleteService(String serviceId) async {
    String mutation = '''
      mutation {
        keepBookingAndDeleteService(id: "$serviceId")
      }
    ''';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken')!;

    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to delete service');
    }

    return result.data?['keepBookingAndDeleteService'] != null;
  }

  static Future<BookServiceModel> getBookService(
      String bookId, String search, int pageSize, int page, String sort) async {
    String query = '''
      query {
        getServicesByBook(
          bookId: "$bookId",
          filter: {search: "$search", pageSize: $pageSize, page: $page, sort: "$sort"}
        ) {
          services {
            id
            description
            duration
            price
            rating
            shortDescription
            reader {
              id
              nickname
              avatarUrl
              language
              countryAccent
            }
            totalOfBooking
            totalOfReview
            imageUrl
            book {
              id
              title
              publisher
              language
              authors {
                name
              }
              categories {
                name
              }
              description
              pageCount
              smallThumbnailUrl
              thumbnailUrl
            }
            serviceType {
              description
              id
              name
            }
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
    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to get book service');
    }

    final bookServiceData = result.data?['getServicesByBook'];
    return BookServiceModel.fromJson(bookServiceData);
  }

  static Future<ServiceModel> getServiceById(
      String serviceId) async {

    String query = '''
      query MyQuery {
        serviceById(id: "$serviceId") {
          createdAt
          description
          duration
          imageUrl
          id
          price
          rating
          shortDescription
          status
          totalOfBooking
          totalOfReview
          reader {
            id
            introductionVideoUrl
            thumbnailUrl
            nickname
            avatarUrl
            countryAccent
            rating
            totalOfReviews
          }
          book {
            id
            title
            publisher
            language
            authors {
              name
            }
            categories {
              name
            }
            description
            pageCount
            smallThumbnailUrl
            thumbnailUrl
          }
          serviceType {
            id
            name
            description
          }
          bookings {
            id
            review
            createAt
            rating
            customer {
              id
              fullName
              imageUrl
            }
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
      throw Exception('Error: ${result.exception}');
    }

    final serviceData = result.data?['serviceById'];

    return ServiceModel.fromJson(serviceData);
  }
}
