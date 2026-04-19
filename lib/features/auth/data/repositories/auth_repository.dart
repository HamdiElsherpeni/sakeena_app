import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failer.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../models/register_request.dart';

class AuthRepository {
  final AuthRemoteDatasource _datasource = AuthRemoteDatasource();

  // ✅ Login + Save Token + Error Handling
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _datasource.login(
        LoginRequest(email: email, password: password),
      );

      await _saveTokens(
        token: response.token,
        refreshToken: response.refreshToken,
      );

      return response;
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    } catch (e) {
      throw ServerFailer('Unexpected error occurred');
    }
  }

  // ✅ Register + Save Token + Error Handling
  Future<AuthResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _datasource.register(
        RegisterRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );

      await _saveTokens(
        token: response.token,
        refreshToken: response.refreshToken,
      );

      return response;
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    } catch (e) {
      throw ServerFailer('Unexpected error occurred');
    }
  }

  // ✅ Logout + Clear Token + Error Handling
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final refreshToken = prefs.getString('refreshToken') ?? '';

      await _datasource.revokeToken(token: token, refreshToken: refreshToken);

      await _clearTokens();
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    } catch (e) {
      throw ServerFailer('Logout failed');
    }
  }

  // ✅ Save Tokens
  Future<void> _saveTokens({
    required String token,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refreshToken', refreshToken);
  }

  // ✅ Clear Tokens
  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refreshToken');
  }
}
