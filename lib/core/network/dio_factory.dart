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
        final isAuthEndpoint = _isAuthPath(options.path);

        if (!isAuthEndpoint) {
          final token = await TokenService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }

        handler.next(options);
      },

      onError: (DioException error, handler) async {
        final statusCode = error.response?.statusCode;
        final isAuthEndpoint = _isAuthPath(error.requestOptions.path);

        print('🔴 Error path: ${error.requestOptions.path}');
        print('🔴 isAuthEndpoint: $isAuthEndpoint');
        print('🔴 statusCode: $statusCode');

        if (statusCode == 401 && !isAuthEndpoint) {
          final refreshExpired = await TokenService.isRefreshTokenExpired();
          print('🔄 refreshExpired: $refreshExpired');
          print(
            '🔄 expiration: ${await TokenService.getRefreshTokenExpiration()}',
          );

          if (refreshExpired) {
            debugPrint('🔴 Refresh token expired → logging out');
            _resolveQueue(null);
            _isRefreshing = false;
            await _handleLogout();
            return handler.next(error);
          }

          if (_isRefreshing) {
            debugPrint('⏳ Refresh in progress → queuing request');
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

          _isRefreshing = true;
          debugPrint('🔄 Starting token refresh...');

          try {
            final newToken = await _tryRefreshToken();

            if (newToken != null) {
              debugPrint('✅ Token refreshed successfully');
              _resolveQueue(newToken);
              _isRefreshing = false;

              final retryResponse = await _retryRequest(
                error.requestOptions,
                dio,
                newToken,
              );
              return handler.resolve(retryResponse);
            } else {
              debugPrint('🔴 Token refresh failed → logging out');
              _resolveQueue(null);
              _isRefreshing = false;
              await _handleLogout();
              return handler.next(error);
            }
          } catch (e) {
            debugPrint('🔴 Token refresh exception: $e → logging out');
            _resolveQueue(null);
            _isRefreshing = false;
            await _handleLogout();
            return handler.next(error);
          }
        }

        handler.next(error);
      },
    );
  }

  // ✅ الحل: استخدام full URL بدون baseUrl
  static Future<String?> _tryRefreshToken() async {
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();
      if (token == null || refreshToken == null) {
        debugPrint('🔴 No token or refreshToken found in storage');
        return null;
      }

      final plainDio = Dio();

      print(
        '🔄 Calling refresh: ${ApiEndpoints.baseUrl}${ApiEndpoints.refresh}',
      );

      final response = await plainDio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.refresh}',
        data: {'token': token, 'refreshToken': refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final data = response.data;
      if (data is! Map) {
        debugPrint('🔴 Refresh response is not a Map: $data');
        return null;
      }

      final newToken = data['token'] as String?;
      final newRefresh = data['refreshToken'] as String?;
      final newExpiration = data['refreshTokenExpiration'] as String?;

      if (newToken == null || newToken.isEmpty) {
        debugPrint('🔴 New token is null or empty in refresh response');
        return null;
      }

      await TokenService.saveTokens(
        token: newToken,
        refreshToken: newRefresh ?? refreshToken,
        refreshTokenExpiration: newExpiration,
      );

      debugPrint('✅ Tokens saved successfully after refresh');
      return newToken;
    } catch (e) {
      debugPrint('🔴 _tryRefreshToken exception: $e');
      return null;
    }
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
      (authPath) =>
          path == authPath ||
          path.endsWith(authPath) ||
          path == '/Auth' && !path.contains('/Auth/'),
    );
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
