import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class NetworkInterceptor extends Interceptor {
  final Dio dio;

  NetworkInterceptor(this.dio);

  bool _isRefreshing = false;

  // Queue of completers for requests waiting for token refresh
  final List<Completer<String?>> _pendingRequests = [];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenService.getToken();

    final isAuthEndpoint = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.forgetPassword,
      ApiEndpoints.verifyCode,
      ApiEndpoints.resetPassword,
      ApiEndpoints.refresh,
      ApiEndpoints.revoke,
    ].any((e) => options.path.contains(e));

    if (!isAuthEndpoint && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    // Don't retry if the failing request itself is a refresh or revoke call
    final isSkippedEndpoint = [
      ApiEndpoints.refresh,
      ApiEndpoints.revoke,
    ].any((e) => err.requestOptions.path.contains(e));

    if (statusCode == 401 && !isSkippedEndpoint) {
      // ── Another refresh is already in flight: queue this request ──────────
      if (_isRefreshing) {
        final completer = Completer<String?>();
        _pendingRequests.add(completer);

        try {
          // Wait until the ongoing refresh resolves
          final newToken = await completer.future;
          if (newToken == null) return handler.next(err);

          final response = await _retry(err.requestOptions, newToken);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }

      // ── First 401: start refresh ────────────────────────────────────────
      _isRefreshing = true;

      try {
        final success = await _refreshToken();
        final newToken = success ? await TokenService.getToken() : null;

        if (!success || newToken == null) {
          await TokenService.clearTokens();
          _resolveQueue(null); // unblock pending requests with null → fail them
          _isRefreshing = false;
          return handler.next(err);
        }

        _resolveQueue(newToken); // unblock pending requests with the new token
        _isRefreshing = false;

        final response = await _retry(err.requestOptions, newToken);
        return handler.resolve(response);
      } catch (e) {
        _resolveQueue(null);
        _isRefreshing = false;
        await TokenService.clearTokens();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  // ── Resolve all queued requests with a token (or null on failure) ─────────
  void _resolveQueue(String? token) {
    for (final c in _pendingRequests) {
      if (!c.isCompleted) c.complete(token);
    }
    _pendingRequests.clear();
  }

  // ── Call the refresh endpoint and persist new tokens ──────────────────────
  Future<bool> _refreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();

      if (token == null || refreshToken == null) return false;

      // Use a plain Dio to avoid re-triggering this interceptor
      final plainDio = Dio(dio.options);

      final response = await plainDio.post(
        ApiEndpoints.refresh,
        data: {'token': token, 'refreshToken': refreshToken},
      );

      final data = response.data;
      if (data is! Map) return false;

      final newToken = data['token'] as String?;
      final newRefresh = data['refreshToken'] as String?;

      if (newToken == null || newToken.isEmpty) return false;

      // Save tokens — update refresh token only when the server returns one
      await TokenService.saveTokens(
        token: newToken,
        refreshToken: newRefresh ?? refreshToken,
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  // ── Clone and replay the original request with the new token ──────────────
  Future<Response> _retry(RequestOptions requestOptions, String token) {
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $token'},
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
