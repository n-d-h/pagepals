import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';

class ReaderService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<List<PopularReader>> getPopularReaders() async {
    var query = '''
    query {
       getListPopularReaders {
          language
          rating
          countryAccent
          description
          experience
          genre
          id
          nickname
          services {
            price
            totalOfReview
          } 
          introductionVideoUrl
          totalOfReviews
          account {
            customer {
              imageUrl
            }         
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
      throw Exception('Failed to load readers');
    }

    final List<dynamic>? readersData = result.data?['getListPopularReaders'];
    if (readersData != null) {
      return readersData
          .map((readerJson) => PopularReader.fromJson(readerJson))
          .toList();
    } else {
      throw Exception('Failed to load read Data');
    }
  }

  static Future<ReaderProfile?> getReaderProfile(String id) async {
    String query = '''
        query{
          getReaderProfile(id: "$id") {
            profile {
              account {
                username
              }
              nickname
              audioDescriptionUrl
              countryAccent
              description
              experience
              genre
              id
              introductionVideoUrl
              language
              rating
              tags
              totalOfBookings
              totalOfReviews
            }
            workingTimeList {
              workingDates {
                date
                timeSlots {
                  startTime
                }
              }
            }
          }
        }
    ''';
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
    ));

    if (result.hasException) {
      throw Exception('Failed to load readers');
    }

    final readersData = result.data?['getReaderProfile'];
    if (readersData != null) {
      return ReaderProfile.fromJson(readersData);
    } else {
      throw Exception('Failed to load read Data');
    }
  }

  static Future<List<PopularReader>> getListActiveReader() async {
    String query = '''
    query {
      getReadersActive {
        audioDescriptionUrl
        countryAccent
        createdAt
        deletedAt
        description
        experience
        genre
        id
        introductionVideoUrl
        language
        nickname
        rating
        status
        tags
        totalOfBookings
        totalOfReviews
        updatedAt
      }
    }
    ''';

    final QueryResult result =
        await graphQLClient.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception('Failed to load readers');
    }

    final List<dynamic>? readersData = result.data?['getReadersActive'];
    if (readersData != null) {
      return readersData
          .map((readerJson) => PopularReader.fromJson(readerJson))
          .toList();
    } else {
      throw Exception('Failed to load read Data');
    }
  }
}
