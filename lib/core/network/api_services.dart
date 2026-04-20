import 'package:dio/dio.dart';
import 'api_client.dart';

class ApiService {
  // ✅ بياخد من ApiClient مش بيعمل Dio جديد
  final Dio _dio = ApiClient.dio;

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(endpoint, queryParameters: queryParameters);
    return response.data;
  }

  Future<dynamic> post({
    required String endpoint,
    required dynamic data,
  }) async {
    final response = await _dio.post(endpoint, data: data);
    return response.data;
  }

  Future<dynamic> put({
    required String endpoint,
    dynamic queryParameters,
    dynamic data,
  }) async {
    final response = await _dio.put(
      endpoint,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.delete(
      endpoint,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
