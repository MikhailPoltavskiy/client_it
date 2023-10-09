import 'dart:async';

import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_it/feature/posts/domain/post_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'post_state.dart';
part 'post_event.dart';
part 'post_cubit.freezed.dart';
// part 'post_cubit.g.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(
    this.repo,
    this.authCubit,
  ) : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSub = authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (value) => add(PostEvent.fetch()),
        notAuthorized: (value) => add(PostEvent.logout()),
      );
    });

    on<_PostEventFetch>(fetchPosts);
    on<_PostEventCreate>(createPost);
    on<_PostEventLogout>(logOut);
  }

  final PostRepo repo;
  final AuthCubit authCubit;
  late final StreamSubscription authSub;

  Future<void> fetchPosts(PostEvent event, Emitter emitter) async {
    if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) return;
    emitter(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await repo.fetchPosts(state.fetchLimit, state.offset).then((value) {
      final Iterable iterable = value;
      final fetcedList = iterable.map((e) => PostEntity.fromJson(e)).toList();
      final mergeList = [...state.postList, ...fetcedList];

      emitter(state.copyWith(
          offset: state.offset + fetcedList.length,
          postList: mergeList,
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      stateError(error, emitter);
      // print('ERROR: ${error}');
      // addError(error);
    });
  }

  Future<void> createPost(PostEvent event, Emitter emitter) async {
    await repo.createPost((event as _PostEventCreate).args).then((value) {
      add(PostEvent.fetch());
    }).catchError((error) {
      stateError(error, emitter);
      // print('ERROR: ${error}');
      // addError(error);
    });
  }

  void logOut(PostEvent event, Emitter emitter) {
    emitter(const PostState());
  }

  // @override
  // void addError(Object error, [StackTrace? stackTrace]) {
  //   emit(state.copyWith(
  //       asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
  //   super.addError(error, stackTrace);
  // }

  // @override
  // PostState? fromJson(Map<String, Object?> json) {
  //   return PostState.fromJson(json);
  // }

  // @override
  // Map<String, Object?>? toJson(PostState state) {
  //   return state.toJson();
  // }

  @override
  Future<void> close() {
    authSub.cancel();
    return super.close();
  }

  void stateError(Object error, Emitter emitter) {
    emitter(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    addError(error);
  }
}
