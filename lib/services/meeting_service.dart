import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/meeting_model.dart';

class MeetingService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<MeetingModel> getMeetingRecordings(String id) async {
    String query = '''
      query MyQuery {
        getMeetingRecordings(meetingId: "$id") {
          from
          next_page_token
          page_count
          page_size
          to
          total_records
          meetings {
            account_id
            download_access_token
            duration
            host_email
            host_id
            id
            password
            recording_count
            recording_files {
              download_url
              file_extension
              file_size
              file_type
              id
              meeting_id
              play_url
              recording_end
              recording_start
              recording_type
              status
            }
            recording_play_passcode
            share_url
            start_time
            timezone
            topic
            total_size
            type
            uuid
          }
        }
      }
    ''';

    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (queryResult.hasException) {
      throw Exception('Error: ${queryResult.exception.toString()}');
    }

    var data = queryResult.data!['getMeetingRecordings'];
    if(data == null) {
      throw Exception('No data found');
    }

    return MeetingModel.fromJson(data);
  }
}