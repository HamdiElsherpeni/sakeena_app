import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class DioFactory {
  DioFactory._();

  static const _defaultTimeout = Duration(seconds: 30);
  static Dio? _dioInstance;
  static void Function()? onLogout;

  static bool _isRefreshing = false;
  static final List<Completer<String?>> _refreshQueue = [];

  static const List<String> _authPaths = [
    '/Auth',
    '/Auth/register',
    '/Auth/refresh',
    '/Auth/revoke-refresh-token',
    '/Auth/forget-password',
    '/Auth/verify-code',
    '/Auth/reset-password',
  ];

  static Dio get dio {
    _dioInstance ??= _createDio();
    return _dioInstance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: _defaultTimeout,
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(_buildAuthInterceptor(dio));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
        ),
      );
    }

    return dio;
  }

  static InterceptorsWrapper _buildAuthInterceptor(Dio dio) {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final isAuth = _isAuthPath(options.path);
        if (!isAuth) {
          final token = await TokenService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        handler.next(options);
      },

      onError: (DioException error, handler) async {
        final statusCode = error.response?.statusCode;
        final isAuth = _isAuthPath(error.requestOptions.path);

        if (statusCode != 401 || isAuth) {
          return handler.next(error);
        }

        // ── تحقق من انتهاء الـ refresh token ──────────────────────────
        final refreshExpired = await TokenService.isRefreshTokenExpired();
        if (refreshExpired) {
          debugPrint('🔴 Refresh token expired → logout');
          _resolveQueue(null);
          _isRefreshing = false;
          await _handleLogout();
          return handler.next(error);
        }

        // ── لو في refresh جاري، أضف الطلب للقائمة ─────────────────────
        if (_isRefreshing) {
          debugPrint('⏳ Queuing request while refreshing...');
          final completer = Completer<String?>();
          _refreshQueue.add(completer);
          try {
            final newToken = await completer.future;
            if (newToken == null) return handler.next(error);
            final retryResponse = await _retryRequest(
              error.requestOptions,
              dio,
              newToken,
            );
            return handler.resolve(retryResponse);
          } catch (_) {
            return handler.next(error);
          }
        }

        // ── ابدأ الـ refresh ───────────────────────────────────────────
        _isRefreshing = true;
        debugPrint('🔄 Refreshing token...');

        try {
          final newToken = await _tryRefreshToken();

          if (newToken != null) {
            debugPrint('✅ Token refreshed');
            _resolveQueue(newToken);
            _isRefreshing = false;
            final retryResponse = await _retryRequest(
              error.requestOptions,
              dio,
              newToken,
            );
            return handler.resolve(retryResponse);
          } else {
            debugPrint('🔴 Refresh failed → logout');
            _resolveQueue(null);
            _isRefreshing = false;
            await _handleLogout();
            return handler.next(error);
          }
        } catch (e) {
          debugPrint('🔴 Refresh exception: $e → logout');
          _resolveQueue(null);
          _isRefreshing = false;
          await _handleLogout();
          return handler.next(error);
        }
      },
    );
  }

  static Future<String?> _tryRefreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();

      debugPrint('🔑 token: $token');
      debugPrint('🔑 refreshToken: $refreshToken');
      debugPrint(
        '🌐 refresh URL: ${ApiEndpoints.baseUrl}${ApiEndpoints.refresh}',
      );

      if (token == null || refreshToken == null) {
        debugPrint('🔴 null tokens');
        return null;
      }
      // ... باقي الكود
      final plainDio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: _defaultTimeout,
          receiveTimeout: _defaultTimeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final response = await plainDio.post(
        ApiEndpoints.refresh,
        data: {'token': token, 'refreshToken': refreshToken},
      );

      final data = response.data;
      if (data is! Map) return null;

      final newToken = data['token'] as String?;
      final newRefresh = data['refreshToken'] as String?;
      final newExpiration = data['refreshTokenExpiration'] as String?;

      if (newToken == null || newToken.isEmpty) return null;

      await TokenService.saveTokens(
        token: newToken,
        refreshToken: newRefresh ?? refreshToken,
        refreshTokenExpiration: newExpiration,
      );

      return newToken;
    } catch (e) {
      debugPrint('🔴 _tryRefreshToken error: $e');
      return null;
    }
  }

  static Future<void> _revokeRefreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();
      if (token == null || refreshToken == null) return;

      final plainDio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: _defaultTimeout,
          receiveTimeout: _defaultTimeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      await plainDio.post(
        ApiEndpoints.revoke,
        data: {'refreshToken': refreshToken},
      );

      debugPrint('✅ Refresh token revoked');
    } catch (e) {
      debugPrint('⚠️ Revoke failed (ignored): $e');
    }
  }

  /// استدعي الدالة دي لما المستخدم يضغط تسجيل الخروج
  static Future<void> logout() async {
    await _revokeRefreshToken();
    await _handleLogout();
  }

  static Future<Response> _retryRequest(
    RequestOptions requestOptions,
    Dio dio,
    String newToken,
  ) async {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
      ),
    );
  }

  static void _resolveQueue(String? token) {
    for (final c in _refreshQueue) {
      if (!c.isCompleted) c.complete(token);
    }
    _refreshQueue.clear();
  }

  static Future<void> _handleLogout() async {
    await TokenService.clearTokens();
    onLogout?.call();
  }

  static bool _isAuthPath(String path) {
    return _authPaths.any(
      (authPath) => path == authPath || path.endsWith(authPath),
    );
  }
}
