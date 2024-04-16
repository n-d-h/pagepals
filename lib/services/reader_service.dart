import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/reader_request_model.dart';
import 'package:pagepals/models/reader_transaction_model.dart';
import 'package:pagepals/models/request_model.dart';
import 'package:pagepals/services/auth_service.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          avatarUrl
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
                email
                phoneNumber
                customer {
                  dob
                }
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
              avatarUrl
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

    GraphQLClient clientWithToken =
        await AuthService.getGraphQLClientWithToken();
    final QueryResult result = await clientWithToken.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
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
        avatarUrl
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

    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

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

  static Future<String> registerReader(ReaderRequestModel request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String account = prefs.getString('account') ?? '';
    AccountModel accountModel =
        AccountModel.fromJson(json.decoder.convert(account));

    String query = '''
      mutation {
        registerReader(
          accountId: "${accountModel.id}",
          data: {
            information: {
              audioDescriptionUrl: "${request.information?.audioDescriptionUrl ?? ''}", 
              avatarUrl: "${request.information?.avatarUrl}", 
              countryAccent: "${request.information?.countryAccent}", 
              description: "${request.information?.description}", 
              genres: "${request.information?.genres}", 
              introductionVideoUrl: "${request.information?.introductionVideoUrl}",
              languages: "${request.information?.languages}", 
              nickname: "${request.information?.nickname}"
            },
            answers: [
              ${request.answers?.map((answer) => '''
                {
                  content: "${answer?.content}",
                  questionId: "${answer?.questionId}"
                }
              ''').join(',')}
            ]
          }
        ) {
          id
        }
      } 
    ''';

    final GraphQLClient clientWithToken =
        await AuthService.getGraphQLClientWithToken();

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to register reader');
    }

    final String? status = result.data?['registerReader']?['id'];
    if (status != null) {
      String accessToken = prefs.getString('accessToken') ?? '';
      AccountModel acc = await AuthenService.getAccount(
          accountModel.username ?? '', accessToken);
      prefs.remove('account');
      prefs.setString('account', json.encoder.convert(acc));
      return 'OK';
    } else {
      throw Exception('Failed to register reader');
    }
  }

  static Future<ReaderTransactionModel> getReaderTransaction(
      String readerId,
      int page,
      int pageSize,
      String startDate,
      String endDate,
      String transactionType) async {
    String query = '''
      query {
        getListTransactionForReader(
          readerId: "$readerId",
          filter: {
            endDate: "$endDate", 
            page: $page, 
            pageSize: $pageSize, 
            startDate: "$startDate", 
            transactionType:"$transactionType"}
        ) {
          list {
            amount
            createAt
            currency
            description
            id
            status
            transactionType
          }
          paging {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to get reader transaction');
    }

    final transactionData = result.data?['getListTransactionForReader'];
    return ReaderTransactionModel.fromJson(transactionData);
  }

  static Future<CommentModel> getListReaderComment(
      String readerId, int page, int pageSize) async {
    String query = '''
      query {
        getReaderReviews(
          readerId: "$readerId"
          pageSize: $pageSize
          page: $page
        ) {
          list {
            date
            rating
            review
            customer {
              fullName
              imageUrl
            }
          }
          pagination {
            currentPage
            pageSize
            sort
            totalOfElements
            totalOfPages
          }
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to get reader comment');
    }

    final commentData = result.data?['getReaderReviews'];

    if (commentData == null) {
      return CommentModel(
        list: [],
      );
    } else {
      var data = CommentModel.fromJson(commentData);
      return data;
    }
  }

  static Future<RequestModel> getRequestByReaderId(String readerId) async {
    String query = '''
      query MyQuery {
        getRequestByReaderId(readerId: "$readerId") {
          createdAt
          description
          id
          interviewAt
          meetingCode
          staffId
          staffName
          state
          updatedAt
        }
      }
    ''';

    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (result.hasException) {
      throw Exception('Failed to get reader comment');
    }

    final requestData = result.data?['getRequestByReaderId'];
    return RequestModel.fromJson(requestData);
  }

  static Future<bool> updateReader(
      String readerId,
      String nickname,
      String avatarUrl,
      String countryAccent,
      String description,
      String genres,
      String languages,
      String introUrl,
      String audioUrl) async {
    String mutation = '''
      mutation {
        updateReader(
          id: "$readerId"
          data: {
            audioDescriptionUrl: "$audioUrl",
            avatarUrl: "$avatarUrl",
            countryAccent: "$countryAccent",
            description: "$description",
            genres: "$genres",
            languages: "$languages", 
            introductionVideoUrl: "$introUrl",
            nickname: "$nickname",
          }
        )
      }
    ''';

    final GraphQLClient clientWithToken =
        await AuthService.getGraphQLClientWithToken();

    final QueryResult result = await clientWithToken.query(
      QueryOptions(
        document: gql(mutation),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to update customer');
    }

    final customerData = result.data?['updateReader'];
    if (customerData != null) {
      AuthenService.updateAccountToSharedPreferences();
      return true;
    } else {
      return false;
    }
  }
}
