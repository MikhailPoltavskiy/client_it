import 'package:client_it/feature/posts/domain/entity/author/author_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';
part 'post_entity.g.dart';

/// PostEntity data class
@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    required int id,
    required String name,
    String? content,
    String? preContent,
    AuthorEntity? author,
  }) = _PostEntity;

  /// Generate PostEntity class from Map<String, dynamic>
  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);
}
