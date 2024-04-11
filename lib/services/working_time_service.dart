import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/working_time_model.dart';
import 'package:pagepals/services/auth_service.dart';

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

    return null;
  }

  static Future<bool> createWorkingTime(String readerId, bool isWeekLy,
      String date, List<String> startTimes) async {
    var mutation = '''
      mutation {
        createReaderWorkingTime(
          workingTime: {
            readerId: "$readerId", 
            isWeekly: $isWeekLy, 
            list: [
              ${startTimes.map((time) => '''
                {
                  date: "$date",
                  startTime: "$time",
                  duration: 60
                }
              ''').join(',')}
            ]
          }
        )
      }
    ''';

    GraphQLClient clientWithToken =
        await AuthService.getGraphQLClientWithToken();

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to create working time');
    }

    return result.data?['createReaderWorkingTime'] != null;
  }
}
