import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class NetworkInterceptor extends Interceptor {
  final Dio dio;
  final void Function()? onLogout;

  NetworkInterceptor(this.dio, {this.onLogout});

  static bool _isRefreshing = false;
  static final List<Completer<String?>> _pendingRequests = [];

  static final List<String> _authPaths = [
    ApiEndpoints.login,
    ApiEndpoints.register,
    ApiEndpoints.forgetPassword,
    ApiEndpoints.verifyCode,
    ApiEndpoints.resetPassword,
    ApiEndpoints.refresh,
    ApiEndpoints.revoke,
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenService.getToken();
    final isAuthEndpoint = _authPaths.any((e) => options.path.contains(e));

    if (!isAuthEndpoint && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final isSkippedEndpoint = _authPaths.any(
      (e) => err.requestOptions.path.contains(e),
    );

    if (statusCode == 401 && !isSkippedEndpoint) {
      if (statusCode == 401 && !isSkippedEndpoint) {
        // ✅ تحقق إن الـ refresh token ما انتهاش قبل ما تجرب refresh
        final refreshExpired = await TokenService.isRefreshTokenExpired();
        print('🔄 refreshExpired: $refreshExpired'); // ← هنا
        print(
          '🔄 expiration: ${await TokenService.getRefreshTokenExpiration()}',
        ); // ← وهنا
      }
      // ✅ تحقق إن الـ refresh token ما انتهاش قبل ما تجرب refresh
      final refreshExpired = await TokenService.isRefreshTokenExpired();
      if (refreshExpired) {
        _resolveQueue(null);
        _isRefreshing = false;
        await _handleLogout();
        return handler.next(err);
      }

      if (_isRefreshing) {
        final completer = Completer<String?>();
        _pendingRequests.add(completer);
        try {
          final newToken = await completer.future;
          if (newToken == null) return handler.next(err);
          final response = await _retry(err.requestOptions, newToken);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }

      _isRefreshing = true;

      try {
        final success = await _refreshToken();
        final newToken = success ? await TokenService.getToken() : null;

        if (!success || newToken == null) {
          _resolveQueue(null);
          _isRefreshing = false;
          await _handleLogout();
          return handler.next(err);
        }

        _resolveQueue(newToken);
        _isRefreshing = false;

        final response = await _retry(err.requestOptions, newToken);
        return handler.resolve(response);
      } catch (_) {
        _resolveQueue(null);
        _isRefreshing = false;
        await _handleLogout();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<void> _handleLogout() async {
    await TokenService.clearTokens();
    onLogout?.call();
  }

  void _resolveQueue(String? token) {
    for (final c in _pendingRequests) {
      if (!c.isCompleted) c.complete(token);
    }
    _pendingRequests.clear();
  }

  Future<bool> _refreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();
      if (token == null || refreshToken == null) return false;

      final plainDio = Dio(dio.options);
      final response = await plainDio.post(
        ApiEndpoints.refresh,
        data: {'token': token, 'refreshToken': refreshToken},
      );

      final data = response.data;
      if (data is! Map) return false;

      final newToken = data['token'] as String?;
      final newRefresh = data['refreshToken'] as String?;
      final newExpiration = data['refreshTokenExpiration'] as String?;

      if (newToken == null || newToken.isEmpty) return false;

      // ✅ احفظ الـ expiration الجديدة بعد كل refresh
      await TokenService.saveTokens(
        token: newToken,
        refreshToken: newRefresh ?? refreshToken,
        refreshTokenExpiration: newExpiration,
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions, String token) {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {...requestOptions.headers, 'Authorization': 'Bearer $token'},
      ),
    );
  }
}
