import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/book_model.dart';

class BookService {
  static Future<List<BookModel>> getAllBooks() async {
    GraphQLClient graphQLClient = client!.value;
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
    return _fetchBooks(graphQLClient, query);
  }

  static Future<List<BookModel>> _fetchBooks(
      GraphQLClient client, String query) async {
    final QueryResult result = await client.query(QueryOptions(
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
}

// var response = await http.post(
//   Uri.parse(baseUrl),
//   headers: {
//     'Content-Type': 'application/json',
//   },
//   body: json.encode({'query': query}),
// );

// if (response.statusCode == 200) {
//   var responseData = json.decode(response.body);
//   var dataJson = responseData['data']['getListBook']['list']
//       .map((x) => BookModel.fromJson(x))
//       .toList();
//   return List<BookModel>.from(dataJson);
// } else {
//   throw Exception('Failed to load books');
// }
