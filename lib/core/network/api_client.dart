import 'package:dio/dio.dart';
import 'package:sakeena_app/core/network/interceptors/network_interceptor.dart';
import 'api_endpoints.dart';

class ApiClient {
  static Dio? _dio;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // ✅ مهم جدًا: نمرر نفس dio
    dio.interceptors.add(NetworkInterceptor(dio));

    return dio;
  }
}