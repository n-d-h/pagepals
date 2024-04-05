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
        fetchPolicy: FetchPolicy.networkOnly,
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

  static Future<bool> createWorkingTime(
      String readerId, bool isWeekLy, String date, String startTime) async {
    var mutation = '''
      mutation createWork {
        createReaderWorkingTime(
          workingTime: {
            readerId: "$readerId", 
            isWeekly: $isWeekLy, 
            list: {
              date: "$date",
              duration: 60,
              startTime: "$startTime"
            }
          }
        )
      }
    ''';

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
          document: gql(mutation), fetchPolicy: FetchPolicy.networkOnly),
    );

    if (result.hasException) {
      throw Exception('Failed to create working time');
    }

    return result.data?['createWorkingTime'] != null;
  }
}
