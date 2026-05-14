import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _refreshTokenExpirationKey = 'refreshTokenExpiration';
  static const String _onboardingKey = 'onboarding_seen';

  // ================= TOKENS =================
  static Future<void> saveTokens({
    required String token,
    required String refreshToken,
    String? refreshTokenExpiration,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
    if (refreshTokenExpiration != null) {
      await prefs.setString(_refreshTokenExpirationKey, refreshTokenExpiration);
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<String?> getRefreshTokenExpiration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenExpirationKey);
  }

  /// بيرجع true لو الـ refresh token منتهي فعلاً
  /// لو مش موجود أو في error → جرب الـ refresh ومتعملش logout
  static Future<bool> isRefreshTokenExpired() async {
    final expirationStr = await getRefreshTokenExpiration();

    // ✅ لو مش موجودة → اعتبرها مش منتهية وجرب الـ refresh
    if (expirationStr == null || expirationStr.isEmpty) return false;

    try {
      final expiration = DateTime.parse(expirationStr).toUtc();
      return DateTime.now().toUtc().isAfter(expiration);
    } catch (_) {
      // ✅ لو في error في الـ parse → جرب الـ refresh
      return false;
    }
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_refreshTokenExpirationKey);
  }

  // ================= ONBOARDING =================

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> clearOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}
