import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../models/register_request.dart';

class AuthRemoteDatasource {
  final Dio _dio = ApiClient.dio;

  // Login
  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  // Register
  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  // Refresh Token
  Future<AuthResponse> refreshToken({
    required String token,
    required String refreshToken,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.refresh,
      data: {'token': token, 'refreshToken': refreshToken},
    );
    return AuthResponse.fromJson(response.data);
  }

  // Revoke Token
  Future<void> revokeToken({
    required String token,
    required String refreshToken,
  }) async {
    await _dio.post(
      ApiEndpoints.revoke,
      data: {'token': token, 'refreshToken': refreshToken},
    );
  }
}
