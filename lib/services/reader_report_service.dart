import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/reader_report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReaderReportService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<ReaderReportModel> getReaderStatistic(
    String readerId,
    String startDate,
    String endDate,
  ) async {
    String query = '''
      query {
        getReaderStatistics(
          readerId: "$readerId",
          startDate: "$startDate",
          endDate: "$endDate"
        ) {
          milestones
          completedBookingData
          canceledBookingData
          successBookingRate
          totalFinishBookingInThisPeriod
          totalIncomeInThisPeriod
          totalAmountShareInThisPeriod
          totalProfitInThisPeriod
          totalRefundInThisPeriod
          allTimeTotalFinishBooking
          allTimeIncome
          totalActiveServices
        }
      }
    ''';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';
    GraphQLClient clientWithToken = GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer $token')
          .concat(graphQLClient.link),
      cache: GraphQLCache(store: HiveStore()),
    );

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if(result.hasException) {
      throw Exception('Error ${result.exception.toString()}');
    }

    return ReaderReportModel.fromJson(result.data!['getReaderStatistics']);
  }
}
