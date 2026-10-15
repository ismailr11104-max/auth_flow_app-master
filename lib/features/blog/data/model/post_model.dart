import 'package:auth_flow_app/features/blog/data/model/profile_model.dart';
import 'package:auth_flow_app/features/blog/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.content,
    super.imageUrl,
    required super.authorId,
    super.author,
    super.category,
    super.viewCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final authorData = json['author'] as Map<String, dynamic>?;

    return PostModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      authorId: (json['author_id'] ?? authorData?['id']) as String? ?? '',
      author: authorData != null ? ProfileModel.fromJson(authorData) : null,
      category: json['category'] as String?,
      viewCount: json['view_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'author_id': authorId,
      'category': category,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? authorId,
    ProfileModel? author,
    String? category,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      author: author ?? this.author as ProfileModel?,
      category: category ?? this.category,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
