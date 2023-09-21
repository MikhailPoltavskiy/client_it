import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_entity.freezed.dart';
part 'author_entity.g.dart';

/// AuthorEntity data class
@freezed
class AuthorEntity with _$AuthorEntity {
  const factory AuthorEntity({
    required int id,
  }) = _AuthorEntity;

  /// Generate AuthorEntity class from Map<String, dynamic>
  factory AuthorEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthorEntityFromJson(json);
}
