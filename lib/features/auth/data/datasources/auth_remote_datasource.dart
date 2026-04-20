import 'package:dio/dio.dart';
import '../../../../core/network/api_services.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../models/register_request.dart';

class AuthRemoteDatasource {
  final ApiService _apiService;

  AuthRemoteDatasource({required ApiService apiService}) : _apiService = apiService;

  // Login
  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _apiService.post(
      endpoint: ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response);
  }

  // Register
  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _apiService.post(
      endpoint: ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response);
  }

  // Refresh Token
  Future<AuthResponse> refreshToken({
    required String token,
    required String refreshToken,
  }) async {
    final response = await _apiService.post(
      endpoint: ApiEndpoints.refresh,
      data: {'token': token, 'refreshToken': refreshToken},
    );
    return AuthResponse.fromJson(response);
  }

  // Revoke Token
  Future<void> revokeToken({
    required String token,
    required String refreshToken,
  }) async {
    await _apiService.post(
      endpoint: ApiEndpoints.revoke,
      data: {'token': token, 'refreshToken': refreshToken},
    );
  }
}
