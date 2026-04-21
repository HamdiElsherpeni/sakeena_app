import 'api_client.dart';

class ApiService {
  ApiService._();

  // ─── GET ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await ApiClient.get(endpoint, queryParameters: queryParameters);
  }

  // ─── POST ─────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
  }) async {
    return await ApiClient.post(endpoint, data: data);
  }

  // ─── PUT ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
  }) async {
    return await ApiClient.put(endpoint, data: data);
  }

  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    dynamic data,
  }) async {
    return await ApiClient.delete(endpoint, data: data);
  }
}
