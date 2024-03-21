import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/category_model.dart';

class CategoryService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<CategoryModel>> getAllCategory() async {
    var query = '''
      query {
        getListCategories{
          id,
          name,
          description,
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic>? categories = result.data!['getListCategories'];
    if (categories == null) {
      throw Exception('No categories found');
    }

    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }
}
