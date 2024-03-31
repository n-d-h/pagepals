import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/question_model.dart';

class QuestionService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<QuestionModel>> getListQuestion() async {
    var query = '''
      query {
        getListQuestion {
          id
          content
        }
      }
    ''';
    final QueryResult result = await graphQLClient.query(QueryOptions(
        document: gql(query), fetchPolicy: FetchPolicy.networkOnly));

    if (result.hasException) {
      throw Exception('Fail to load questions');
    }

    final List<dynamic>? questionsData = result.data?['getListQuestion'];
    if (questionsData != null) {
      return questionsData
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList();
    } else {
      throw Exception('Fail to load question data');
    }
  }
}
