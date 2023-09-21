part of 'post_cubit.dart';

/// PostState data class
@freezed
class PostState with _$PostState {
  const factory PostState({
    @JsonKey(ignore: true) AsyncSnapshot? asyncSnapshot,
    @Default([]) List<PostEntity> postList,
  }) = _PostState;

  /// Generate PostState class from Map<String, Object?>
  factory PostState.fromJson(Map<String, Object?> json) =>
      _$PostStateFromJson(json);
}
