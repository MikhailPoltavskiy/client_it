import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());
  final AuthRepository authRepository;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signIn(
        password: password,
        username: username,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  void logOut() => emit(AuthState.notAuthorized());

  Future<void> signUp({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signUp(
        password: password,
        username: username,
        email: email,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<String?> refreshToken() async {
    final refreshToken =
        state.whenOrNull(authorized: (userEntity) => userEntity.refreshToken);
    try {
      // final UserEntity userEntity =
      return await authRepository.refreshToken(refreshToken: refreshToken).then(
        (value) {
          final UserEntity userEntity = value;
          emit(AuthState.authorized(userEntity));
          return userEntity.accessToken;
        },
      );
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> getProfile() async {
    emit(AuthState.waiting());
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      final UserEntity newUserEntity = await authRepository.getProfile();
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
          email: newUserEntity.email,
          username: newUserEntity.username,
        )),
      ));
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, 'Успешное получение данных'));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void _updateUserState(AsyncSnapshot asyncSnapshot) {
    emit(state.maybeWhen(
      orElse: () => state,
      authorized: (userEntity) {
        return AuthState.authorized(userEntity.copyWith(
          userState: asyncSnapshot,
        ));
      },
    ));
  }

  Future<void> userUpdate({
    String? username,
    String? email,
  }) async {
    // emit(AuthState.waiting());
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      final bool isEmptyEmail = email?.trim().isEmpty == true;
      final bool isEmptyUsername = username?.trim().isEmpty == true;

      final UserEntity newUserEntity = await authRepository.userUpdate(
        email: isEmptyEmail ? null : email,
        username: isEmptyUsername ? null : username,
      );
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
          email: newUserEntity.email,
          username: newUserEntity.username,
        )),
      ));
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, 'Успешное обновление данных'));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> passwordUpdate({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));

      if (newPassword.trim().isEmpty == true) {
        throw ErrorEntity(message: 'Новый пароль пустой');
      }
      final message = await authRepository.passwordUpdate(
        newPassword: newPassword,
        oldPassword: oldPassword,
      );

      _updateUserState(AsyncSnapshot.withData(ConnectionState.done, message));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  // Future<void> userUpdate({
  //   String? username,
  //   String? email,
  // }) async {
  //   try {
  //     final bool isEmptyEmail = email?.trim().isEmpty == true;
  //     final bool isEmptyUsername = username?.trim().isEmpty == true;

  //     final UserEntity newUserEntity = await authRepository.userUpdate(
  //         email: isEmptyEmail ? null : email,
  //         username: isEmptyUsername ? null : username);
  //     emit(state.maybeWhen(
  //       orElse: () => state,
  //       authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
  //           email: newUserEntity.email, username: newUserEntity.username)),
  //     ));
  //   } catch (error, st) {
  //     addError(error, st);
  //   }
  // }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }
}
