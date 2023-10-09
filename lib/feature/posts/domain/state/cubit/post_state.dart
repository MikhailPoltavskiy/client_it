part of 'post_cubit.dart';

/// PostState data class
@freezed
class PostState with _$PostState {
  const factory PostState({
    @JsonKey(includeFromJson: false, includeToJson: false)
    AsyncSnapshot? asyncSnapshot,
    @Default([]) List<PostEntity> postList,
    @Default(3) int fetchLimit,
    @Default(0) int offset,
  }) = _PostState;

  /// Generate PostState class from Map<String, Object?>
  // factory PostState.fromJson(Map<String, Object?> json) =>
  //     _$PostStateFromJson(json);
}
