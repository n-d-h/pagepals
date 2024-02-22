import 'dart:convert';
import 'package:pagepals/models/book_model.dart';
import 'package:http/http.dart' as http;

class BookService {

  static const String baseUrl = 'https://pagepals.azurewebsites.net/graphql';

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

    var response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) {
      var data = response.body;
      var dataJsonParam = json.decode(data);
      var dataJson = json.decode(data)['data']['getListBook']['list'].map((x) => BookModel.fromJson(x)).toList();
      return List<BookModel>.from(dataJson);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
