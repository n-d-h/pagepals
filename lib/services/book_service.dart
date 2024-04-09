import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/models/book_models/customer_book.dart';
import 'package:pagepals/models/google_book.dart';

class BookService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<CustomerBook> getAllBooks(
      String author, String categoryId,
      int page, int pageSize, String search, String sort) async {
    var query = '''
      query {
        getListBookForCustomer(
          searchBook: {
            author: "$author",
            categoryId: "$categoryId",
            page: $page, 
            pageSize: $pageSize, 
            search: "$search", 
            sort: "$sort"}
        ) {
          list {
            authors {
              id
              name
            }
            categories {
              id
              name
            }
            description
            externalId
            id
            language
            pageCount
            publishedDate
            publisher
            smallThumbnailUrl
            thumbnailUrl
            title
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

    // Use the provided client to execute the query
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to load books');
    }

    final Map<String, dynamic>? booksData =
        result.data?['getListBookForCustomer'];
    if (booksData != null) {
      return CustomerBook.fromJson(booksData);
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
      return booksData.isNotEmpty
          ? booksData.map((bookJson) => BookModel.fromJson(bookJson)).toList()
          : [BookModel(book: null, services: [])];
    } else {
      return [BookModel(book: null, services: [])];
    }
  }

  static Future<List<GoogleBookModel>> getGoogleBooks(
      String author, String title, int page, int pageSize) async {
    final String query = '''
      query {
        searchBook(
          author: "$author", 
          title: "$title",
          page: $page, 
          pageSize: $pageSize
        ) {
          items {
            id
            volumeInfo {
              authors
              categories
              description
              imageLinks {
                smallThumbnail
                thumbnail
              }
              language
              pageCount
              publishedDate
              publisher
              title
            }
          }
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to load books: ${result.exception.toString()}');
    }

    final List<dynamic> bookData = result.data?['searchBook']?['items'] ?? [];
    return bookData.map((item) => GoogleBookModel.fromJson(item)).toList();
  }
}
