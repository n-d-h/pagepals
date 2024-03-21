import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_model.dart';

class BookService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<BookModel>> getAllBooks() async {
    var query = '''
    query {
      getListBook(
        query : {
          search : "",
          sort: "asc",
        }
      ) {
        list {
          id,
          title,
          longTitle,
          author,
          publisher,
          pages,
          language,
          overview,
          imageUrl,
          edition,
          status,
          createdAt,
          category { 
              id,
              name,
              description
          },
          chapters {
              id,
              chapterNumber,
              pages
          }
        },
        pagination {
            totalOfPages,
            totalOfElements,
            currentPage,
            pageSize
        }
      }
    }
  ''';

    // Use the provided client to execute the query
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
    ));

    if (result.hasException) {
      throw Exception('Failed to load books');
    }

    final List<dynamic>? booksData = result.data?['getListBook']?['list'];
    if (booksData != null) {
      return booksData.map((bookJson) => BookModel.fromJson(bookJson)).toList();
    } else {
      throw Exception('Failed to parse books data');
    }
  }

  static Future<List<BookModel>> getReaderBooks(String readerId) async {
    var query = '''
        query {
          getReaderBooks(id: "$readerId") {
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
            services {
              id
              description
              duration
              price
              rating
              totalOfBooking
              totalOfReview
              serviceType {
                id
                name
              }
            }
          }
        }
    ''';
    // Use the provided client to execute the query
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to load books');
    }

    final List<dynamic>? booksData = result.data?['getReaderBooks'];
    if (booksData != null) {
      return booksData.map((bookJson) => BookModel.fromJson(bookJson)).toList();
    } else {
      throw Exception('Failed to parse books data');
    }
  }
}
