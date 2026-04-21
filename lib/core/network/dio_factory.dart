import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/network/interceptors/network_interceptor.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio() {
    final Duration defaultTimeout = const Duration(seconds: 30);

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: defaultTimeout,
        receiveTimeout: defaultTimeout,
        sendTimeout: defaultTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      NetworkInterceptor(dio), // ✅ بيتعامل مع الـ 401 و refresh token
      PrettyDioLogger(
        // ✅ logging
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false, // مش محتاجينه عادةً
        error: true,
      ),
    ]);

    return dio;
  }
}
