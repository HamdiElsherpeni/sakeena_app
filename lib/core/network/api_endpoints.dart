class ApiEndpoints {
  ApiEndpoints._(); // منع الـ instantiation

  static const String baseUrl = 'http://sakeena.runasp.net';

  // Auth
  static const String login = '/Auth';
  static const String register = '/Auth/register';
  static const String refresh = '/Auth/refresh';
  static const String revoke = '/Auth/revoke-refresh-token';
  static const String forgetPassword = '/Auth/forget-password'; // ✅ ناقص
  static const String verifyCode = '/Auth/verify-code'; // ✅ ناقص
  static const String resetPassword = '/Auth/reset-password'; // ✅ ناقص

  // Account
  static const String profile = '/account/profile';
  static const String updateProfile = '/account/update-profile';
  static const String changePassword = '/account/change-password';

  // Chat
  static const String ask = '/api/Chat/ask'; // ✅ ناقص
}
