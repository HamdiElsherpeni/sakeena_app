import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class NetworkInterceptor extends Interceptor {
  final Dio dio;

  NetworkInterceptor(this.dio);

  bool _isRefreshing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenService.getToken();

    final isAuthRequest = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.forgetPassword,
      ApiEndpoints.verifyCode,
      ApiEndpoints.resetPassword,
    ].any((e) => options.path.contains(e));

    if (!isAuthRequest && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401 &&
        !err.requestOptions.path.contains(ApiEndpoints.refresh)) {
      try {
        if (_isRefreshing) {
          // ⛔ لو refresh شغال بالفعل، استنى شوية
          await Future.delayed(const Duration(milliseconds: 500));
        }

        _isRefreshing = true;

        final token = await TokenService.getToken();
        final refreshToken = await TokenService.getRefreshToken();

        final response = await dio.post(
          ApiEndpoints.refresh,
          data: {'token': token, 'refreshToken': refreshToken},
        );

        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];

        if (newToken == null) throw Exception('No token returned');

        await TokenService.saveTokens(
          token: newToken,
          refreshToken: newRefreshToken,
        );

        _isRefreshing = false;

        // 🔁 retry request
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        _isRefreshing = false;

        await TokenService.clearTokens();
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}
