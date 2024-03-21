import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/working_time_model.dart';

class WorkingTimeService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<WorkingTimeModel?> getWorkingTime(String readerId) async {
    var query = '''
    query {
      getWorkingTimesAvailableByReader(
        readerId: "$readerId"
      ) {
        workingDates {
          timeSlots {
            id
            startTime
          }
          date
        }
      }
    }
    ''';

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to get working time');
    }

    var workingTimeData = result.data?['getWorkingTimesAvailableByReader'];

    if (workingTimeData != null) {
      return WorkingTimeModel.fromJson(workingTimeData);
    }
  }
}
