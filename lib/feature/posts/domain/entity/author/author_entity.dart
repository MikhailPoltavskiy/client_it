import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_entity.freezed.dart';
part 'author_entity.g.dart';

/// AuthorEntity data class
@freezed
class AuthorEntity with _$AuthorEntity {
  const factory AuthorEntity({
    required int id,
  }) = _AuthorEntity;

  /// Generate AuthorEntity class from Map<String, Object?>
  factory AuthorEntity.fromJson(Map<String, Object?> json) =>
      _$AuthorEntityFromJson(json);
}
