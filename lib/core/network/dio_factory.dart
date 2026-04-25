import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/network/interceptors/network_interceptor.dart';

class DioFactory {
  DioFactory._();

  /// Optional logout callback — pass it once from your app entry point.
  /// Example (with go_router):
  ///   DioFactory.onLogout = () => router.go('/login');
  static void Function()? onLogout;

  static Dio createDio() {
    final defaultTimeout = const Duration(seconds: 30);

    final dio = Dio(
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
      NetworkInterceptor(dio, onLogout: onLogout),
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    ]);

    return dio;
  }
}
