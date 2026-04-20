import 'package:dio/dio.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'dio_factory.dart';

class ApiClient {
  ApiClient._(); // ✅ مينفعش حد يعمل instance منه

  static Dio? _dio;

  // ✅ instance واحدة بس للكل (Singleton)
  static Dio get dio {
    _dio ??= DioFactory.createDio(
      baseUrl: ApiEndpoints.baseUrl,
    ); // بياخد من DioFactory
    return _dio!;
  }
}
