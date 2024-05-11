import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/book_models/customer_book.dart' as CusBook;
import 'package:pagepals/models/google_book.dart';

class BookService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<CusBook.CustomerBook> getAllBooks(
      String author,
      String categoryId,
      int page,
      int pageSize,
      String search,
      String sort) async {
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
      if (booksData['list'].isEmpty) {
        return CusBook.CustomerBook(
          list: [CusBook.Book(id: null)],
          pagination: null,
        );
      }
      return CusBook.CustomerBook.fromJson(booksData);
    } else {
      throw Exception('Failed to parse books data');
    }
  }

  static Future<BookModel> getReaderBooks(
      String readerId, String title, int page, int pageSize) async {
    var query = '''
        query {
          getReaderBooks(id: "$readerId", 
            filter: {title: "$title", page: $page, pageSize: $pageSize}) {
            list {
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
                imageUrl
                totalOfBooking
                totalOfReview
                serviceType {
                  id
                  name
                  description
                }
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
    // Use the provided client to execute the query
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to load books');
    }

    var booksData = result.data?['getReaderBooks'];
    if (booksData != null) {
      BookModel data = BookModel.fromJson(booksData);
      if (data.list!.isNotEmpty) {
        return data;
      } else {
        return BookModel(list: [Books(book: null, services: [])]);
      }
    } else {
      return BookModel(list: [Books(book: null, services: [])]);
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

  static Future<Book> getBookById(String bookId) async {
    final String query = """
    query {
      getBookById(id: "$bookId") {
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
    }
    """;

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to load book: ${result.exception.toString()}');
    }

    final Map<String, dynamic>? bookData = result.data?['getBookById'];
    if (bookData != null) {
      return Book.fromJson(bookData);
    } else {
      throw Exception('Failed to parse book data');
    }
  }
}
