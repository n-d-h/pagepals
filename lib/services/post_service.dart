import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/post_model.dart';
import 'package:pagepals/services/auth_service.dart';

class PostService {
  static GraphQLClient graphQLClient = client!.value;

  static Future<PostModel> getAllPosts(int page, int pageSize) async {
    var query = '''
      query {
        getAllPosts(page: $page, pageSize: $pageSize, sort: "desc") {
          list {
            content
            id
            createdAt
            postImages
            reader {
              avatarUrl
              id
              nickname
            }
            title
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
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data = result.data?['getAllPosts'];
    if (data == null) {
      throw Exception('No data found');
    }

    return PostModel.fromJson(data);
  }

  static Future<PostModel> getPostByReaderId(
      String readerId, int page, int pageSize) async {
    var query = '''
      query {
        getAllPostsByReaderId(
          page: $page, pageSize: $pageSize, readerId: "$readerId", sort: "desc"
        ) {
          list {
            content
            createdAt
            id
            postImages
            title
            reader {
              avatarUrl
              id
              nickname
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
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data = result.data?['getAllPostsByReaderId'];
    if (data == null) {
      throw Exception('No data found');
    }

    return PostModel.fromJson(data);
  }

  static Future<void> createPost(
      String content, List<String> postImages, String readerId, String title) async {
    var mutation = '''
      mutation MyMutation {
        savePost(post: {
            content: "$content", 
            postImages: [
              ${postImages.map((e) => '"$e"').join(',')}
            ],
            readerId: "$readerId", 
            title: "$title"
        }) {
          content
          createdAt
          id
          postImages
          title
          reader {
            id
            avatarUrl
            nickname
          }
        }
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
      throw Exception('Failed to create post');
    }

    final Map<String, dynamic>? data = result.data?['savePost'];
    if (data == null) {
      throw Exception('No data found');
    }
  }

  Future<void> updatePost(
    String content,
    List<String> postImages,
    String readerId,
    String title,
    String postId,
  ) async {
    var mutation = '''
      mutation MyMutation {
        updatePost(
          id: "$postId", 
          post: {
            content: "$content", 
            postImages: [
              ${postImages.map((e) => '"$e"').join(',')}
            ], 
            title: "$title",
        }) {
          content
          createdAt
          id
          postImages
          title
          reader {
            id
            nickname
            avatarUrl
          }
        }
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
      throw Exception('Failed to update post');
    }

    final Map<String, dynamic>? data = result.data?['updatePost'];
    if (data == null) {
      throw Exception('No data found');
    }
  }

  Future<void> deletePost(String postId) async {
    var mutation = '''
      mutation MyMutation {
        deletePost(id: "$postId") {
          content
          createdAt
          postImages
          id
          title
        }
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
      throw Exception('Failed to delete post');
    }

    final bool? data = result.data?['deletePost'];
    if (data == null) {
      throw Exception('No data found');
    }
  }
}
