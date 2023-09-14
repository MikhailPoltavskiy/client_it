import 'package:client_it/app/di/init_di.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = locator.get<AuthCubit>().state.whenOrNull(
          authorized: (userEntity) => userEntity.accessToken,
        );
    if (accessToken == null) {
      super.onRequest(options, handler);
    }
    final headers = options.headers;
    headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options.copyWith(headers: headers), handler);
  }
}
