import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/services/token_service.dart';

class DioFactory {
  DioFactory._();

  static const _timeout = Duration(seconds: 30);
  static Dio? _dio;

  static bool _isRefreshing = false;
  static final List<Completer<String?>> _queue = [];

  static void Function()? onLogout;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(_authInterceptor(dio));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          error: true,
        ),
      );
    }

    return dio;
  }

  static InterceptorsWrapper _authInterceptor(Dio dio) {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenService.getToken();

        final isAuthRequest = _isAuthPath(options.path);

        if (!isAuthRequest && token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },

      onError: (DioException error, handler) async {
        final statusCode = error.response?.statusCode;
        final path = error.requestOptions.path;

        final isAuthRequest = _isAuthPath(path);

        if (kDebugMode) {
          print("🔴 ERROR: $path");
          print("🔴 STATUS: $statusCode");
        }

        if (statusCode == 401 && !isAuthRequest) {
          final refreshExpired = await TokenService.isRefreshTokenExpired();

          if (refreshExpired) {
            _resolveQueue(null);
            _isRefreshing = false;
            await _logout();
            return handler.next(error);
          }

          if (_isRefreshing) {
            final c = Completer<String?>();
            _queue.add(c);

            try {
              final newToken = await c.future;
              if (newToken == null) return handler.next(error);

              final retry = await _retry(error.requestOptions, newToken, dio);
              return handler.resolve(retry);
            } catch (_) {
              return handler.next(error);
            }
          }

          _isRefreshing = true;

          try {
            final newToken = await _refreshToken();

            if (newToken == null) {
              _resolveQueue(null);
              _isRefreshing = false;
              await _logout();
              return handler.next(error);
            }

            _resolveQueue(newToken);
            _isRefreshing = false;

            final retry = await _retry(error.requestOptions, newToken, dio);
            return handler.resolve(retry);
          } catch (e) {
            _resolveQueue(null);
            _isRefreshing = false;
            await _logout();
            return handler.next(error);
          }
        }

        handler.next(error);
      },
    );
  }

  // ================= REFRESH TOKEN =================

  static Future<String?> _refreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }

      final plainDio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
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
      final expiration = data['refreshTokenExpiration'] as String?;

      if (newToken == null || newToken.isEmpty) return null;

      await TokenService.saveTokens(
        token: newToken,
        refreshToken: newRefresh ?? refreshToken,
        refreshTokenExpiration: expiration,
      );

      return newToken;
    } catch (e) {
      debugPrint("🔴 refresh error: $e");
      return null;
    }
  }

  // ================= RETRY =================

  static Future<Response> _retry(
    RequestOptions request,
    String token,
    Dio dio,
  ) {
    return dio.request(
      request.path,
      data: request.data,
      queryParameters: request.queryParameters,
      options: Options(
        method: request.method,
        headers: {...request.headers, 'Authorization': 'Bearer $token'},
      ),
    );
  }

  // ================= QUEUE =================

  static void _resolveQueue(String? token) {
    for (final c in _queue) {
      if (!c.isCompleted) c.complete(token);
    }
    _queue.clear();
  }

  // ================= LOGOUT =================

  static Future<void> _logout() async {
    await TokenService.clearTokens();
    onLogout?.call();
  }

  // ================= AUTH PATHS =================

  static bool _isAuthPath(String path) {
    final clean = path.split('?').first;

    return _authPaths.any((e) => clean == e || clean.endsWith(e));
  }

  static const List<String> _authPaths = [
    '/Auth',
    '/Auth/register',
    '/Auth/refresh',
    '/Auth/revoke-refresh-token',
    '/Auth/forget-password',
    '/Auth/verify-code',
    '/Auth/reset-password',
  ];
}
