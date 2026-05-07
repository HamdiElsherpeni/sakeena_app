import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';

class ApiClient {
  ApiClient._();

  // ✅ بيستخدم نفس الـ singleton دايماً
  static Dio get _dio => DioFactory.dio;

  // ─── GET ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    }
  }

  // ─── POST ─────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    }
  }

  // ─── PUT ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    }
  }

  // ─── DELETE ───────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    }
  }

  // ─── Handle Response ──────────────────────────────────────────────────────
  static Map<String, dynamic> _handleResponse(Response response) {
    final data = response.data;
    if (data is Map<String, dynamic>) return data;
    return {'data': data};
  }
}
