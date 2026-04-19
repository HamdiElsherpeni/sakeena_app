import 'package:dio/dio.dart';
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

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // ✅ لو التوكن انتهى
    if (err.response?.statusCode == 401 &&
        err.requestOptions.path != '/refresh') {
      try {
        final refreshToken = await TokenService.getRefreshToken();

        // ✅ نطلب توكن جديد
        final response = await dio.post(
          '/refresh',
          data: {
            'refreshToken': refreshToken,
          },
        );

        final newToken = response.data['token'];
        final newRefreshToken = response.data['refreshToken'];

        // ✅ نحفظ التوكن الجديد
        await TokenService.saveTokens(
          token: newToken,
          refreshToken: newRefreshToken,
        );

        // ✅ نعيد نفس الريكوست
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(requestOptions);

        return handler.resolve(retryResponse);
      } catch (e) {
        // ❌ لو الريفرش فشل → سيبه يكمل error
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}