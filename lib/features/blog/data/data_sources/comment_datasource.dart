import 'package:auth_flow_app/features/blog/data/model/comment_model.dart';

abstract class CommentDataSource {
  Future<CommentModel> addComment({
    required String postId,
    required String content,
    required String authorId,
  });

  Future<List<CommentModel>> getComments({required String postId});

  Future<void> deleteComment(String id);
}
