import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/models/seminar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeminarService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<SeminarModel> getAllSeminarsByReaderId(
    String readerId,
    int page,
    int pageSize,
  ) async {
    String query = '''
      query MyQuery {
        getAllSeminarsByReaderId(
          readerId: "$readerId",
          page: $page, 
          pageSize: $pageSize, 
          sort: "desc"
        ) {
          list {
            activeSlot
            createdAt
            description
            duration
            id
            imageUrl
            limitCustomer
            price
            startTime
            status
            title
            updatedAt
            reader {
              id
              nickname
              avatarUrl
            }
            book {
              id
              authors {
                id
                name
              }
              categories {
                id
                name
              }
              description
              language
              pageCount
              publishedDate
              publisher
              thumbnailUrl
              smallThumbnailUrl
              title
            }
          }
          pagination {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
        }
      }
    ''';

    QueryResult queryResult = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (queryResult.hasException) {
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    var data = queryResult.data!['getAllSeminarsByReaderId'];
    if (data == null) {
      throw Exception('Error: No data found');
    }

    return SeminarModel.fromJson(data);
  }

  static Future<SeminarModel> getAllSeminars(int page, int pageSize) async {
    String query = '''
      query MyQuery {
        getAllSeminars(page: $page, pageSize: $pageSize, sort: "desc") {
          list {
            activeSlot
            createdAt
            description
            duration
            id
            imageUrl
            limitCustomer
            price
            startTime
            status
            title
            updatedAt
            reader {
              id
              nickname
              avatarUrl
            }
            book {
              id
              authors {
                id
                name
              }
              categories {
                id
                name
              }
              description
              language
              pageCount
              publishedDate
              publisher
              thumbnailUrl
              smallThumbnailUrl
              title
            }
          }
          pagination {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
        }
      }
    ''';

    QueryResult queryResult = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (queryResult.hasException) {
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    var data = queryResult.data!['getAllSeminars'];
    if (data == null) {
      throw Exception('Error: No data found');
    }

    return SeminarModel.fromJson(data);
  }

  static Future<bool> createSeminar(
    String readerId,
    int activeSlot,
    GoogleBookModel book,
    String description,
    int duration,
    String imageUrl,
    int limitCustomer,
    int price,
    String startTime,
    String title,
  ) async {
    String mutation = '''
      mutation MyMutation {
        createSeminar(
          seminar: {
            activeSlot: $activeSlot, 
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
            imageUrl: "$imageUrl", 
            limitCustomer: $limitCustomer, 
            price: $price, 
            readerId: "$readerId", 
            startTime: "$startTime", 
            title: "$title"
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
      throw Exception('Failed to create seminar');
    }

    return result.data!['createSeminar']?['id'] != null;
  }

  static Future<bool> deleteSeminar(String seminarId) async {
    String mutation = '''
      mutation MyMutation {
        deleteSeminar(id: "$seminarId") {
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
      throw Exception('Failed to delete seminar');
    }

    var data = result.data!['deleteSeminar'];

    return data?['id'] != null;
  }

  static Future<bool> updateSeminar(
    String id,
    String readerId,
    int activeSlot,
    String description,
    int duration,
    String imageUrl,
    int limitCustomer,
    int price,
    String startTime,
    String title,
  ) async {
    String mutation = '''
      mutation MyMutation {
        updateSeminar(
          id: "$id"
          readerId: "$readerId"
          seminar: {
            activeSlot: $activeSlot, 
            description: "$description", 
            duration: $duration, 
            imageUrl: "$imageUrl", 
            limitCustomer: $limitCustomer, 
            price: $price, 
            startTime: "$startTime", 
            title: "$title"
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
      throw Exception('Failed to update seminar');
    }

    return result.data!['updateSeminar']?['id'] != null;
  }

  static Future<bool> joinSeminar(String customerId, String seminarId) async {
    String mutation = '''
      mutation MyMutation {
        joinSeminar(
          customerId: "$customerId", 
          seminarId: "$seminarId"
        ) {
          booking {
            id
            cancelReason
            createAt
            description
            promotionCode
            rating
            review
            startAt
            totalPrice
            updateAt
          }
          seminar {
            activeSlot
            createdAt
            description
            duration
            id
            imageUrl
            limitCustomer
            price
            startTime
            status
            title
            updatedAt
          }
        }
      }
    ''';
    QueryResult queryResult = await graphQLClient.query(QueryOptions(
      document: gql(mutation),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (queryResult.hasException) {
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    var data = queryResult.data!['joinSeminar'];
    if (data == null) {
      throw Exception('Error: No data found');
    }

    return data['booking'] != null;
  }
}
