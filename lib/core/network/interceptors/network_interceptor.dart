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

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (kDebugMode) {
      print('┌── REQUEST ──────────────────────────────');
      print('│ [${options.method}] ${options.uri}');
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

    // ✅ التصحيح: مقارنة الـ path بـ ApiEndpoints.refresh
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(ApiEndpoints.refresh)) {
      try {
        final token = await TokenService.getToken();
        final refreshToken = await TokenService.getRefreshToken();

        // ✅ التصحيح: الـ endpoint الصح
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

        // ✅ نعيد نفس الـ request بالتوكن الجديد
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        // ❌ الريفرش فشل → نعمل logout
        await TokenService.clearTokens();
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}
