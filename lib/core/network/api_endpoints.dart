class ApiEndpoints {
  static const String baseUrl = 'http://sakeena.runasp.net';

  // Auth
  static const String login = '/Auth';
  static const String register = '/Auth/register';
  static const String refresh = '/Auth/refresh';
  static const String revoke = '/Auth/revoke-refresh-token';

  // Account
  static const String profile = '/account/profile';
  static const String updateProfile = '/account/update-profile';
  static const String changePassword = '/account/change-password';
}