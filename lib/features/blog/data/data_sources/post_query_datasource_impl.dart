import 'package:auth_flow_app/core/error/exceptions.dart';
import 'package:auth_flow_app/core/network/supa_base/database_client.dart';
import 'package:auth_flow_app/features/blog/data/data_sources/post_query_datasource.dart';
import 'package:auth_flow_app/features/blog/data/model/post_model.dart';

class PostQueryDataSourceImpl implements PostQueryDataSource {
  final DatabaseClient _databaseClient;

  PostQueryDataSourceImpl(this._databaseClient);

  @override
  Future<List<PostModel>> getPosts({
    int? rangeFrom,
    int? rangeTo,
    String? category,
  }) async {
    try {
      final filters = <String, dynamic>{};
      if (category != null) {
        filters['category'] = category;
      }
      final response = await _databaseClient.select(
        'posts',
        columns: '*, author:profiles!author_id(*)',
        filters: filters.isNotEmpty ? filters : null,
        rangeFrom: rangeFrom,
        rangeTo: rangeTo,
        orderBy: 'created_at',
        ascending: false,
      );
      return response.map((e) => PostModel.fromJson(e)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to get posts: ${e.toString()}');
    }
  }

  @override
  Future<List<PostModel>> getMyPosts({
    required String userId,
    String? category,
  }) async {
    try {
      final filters = <String, dynamic>{'author_id': userId};
      if (category != null) {
        filters['category'] = category;
      }
      final response = await _databaseClient.select(
        'posts',
        columns: '*, author:profiles!author_id(*)',
        filters: filters,
        orderBy: 'created_at',
        ascending: false,
      );
      return response.map((e) => PostModel.fromJson(e)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to get my posts: ${e.toString()}');
    }
  }

  @override
  Future<List<PostModel>> searchPosts({required String query}) async {
    try {
      final response = await _databaseClient.search(
        'posts',
        column: 'title',
        query: query,
        columns: '* ,author:profiles!author_id(*)',
      );
      return response.map((e) => PostModel.fromJson(e)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to search posts: ${e.toString()}');
    }
  }
}
