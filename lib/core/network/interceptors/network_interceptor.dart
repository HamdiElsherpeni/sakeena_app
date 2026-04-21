import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class NetworkInterceptor extends Interceptor {
  final Dio dio;

  NetworkInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenService.getToken();

    // 🔥 endpoints اللي مش محتاجة Authorization
    final isAuthRequest = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.forgetPassword,
      ApiEndpoints.verifyCode,
      ApiEndpoints.resetPassword,
    ].any((endpoint) => options.path.contains(endpoint));

    // ✅ ضيف التوكن بس لو مش request خاص بالـ auth
    if (!isAuthRequest && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.remove('Authorization'); // 🔥 مهم
    }

    if (kDebugMode) {
      print('┌── REQUEST ──────────────────────────────');
      print('│ [${options.method}] ${options.uri}');
      print('│ Headers: ${options.headers}');
      if (options.data != null) print('│ Body: ${options.data}');
      print('└─────────────────────────────────────────');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('┌── RESPONSE ─────────────────────────────');
      print('│ [${response.statusCode}] ${response.requestOptions.uri}');
      print('│ Data: ${response.data}');
      print('└─────────────────────────────────────────');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print('┌── ERROR ────────────────────────────────');
      print('│ [${err.response?.statusCode}] ${err.requestOptions.uri}');
      print('│ Message: ${err.message}');
      print('└─────────────────────────────────────────');
    }

    // 🔥 لو 401 اعمل refresh token
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(ApiEndpoints.refresh)) {
      try {
        final token = await TokenService.getToken();
        final refreshToken = await TokenService.getRefreshToken();

        final response = await dio.post(
          ApiEndpoints.refresh,
          data: {'token': token, 'refreshToken': refreshToken},
        );

        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];

        await TokenService.saveTokens(
          token: newToken,
          refreshToken: newRefreshToken,
        );

        // ✅ إعادة نفس الطلب بالتوكن الجديد
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        // ❌ فشل refresh → logout
        await TokenService.clearTokens();
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}
