class ApiEndpoints {
  ApiEndpoints._(); // منع الـ instantiation

  static String baseUrl = 'http://sakeena.runasp.net';

  // Auth
  static String login = '/Auth';
  static String register = '/Auth/register';
  static String refresh = '/Auth/refresh';
  static String revoke = '/Auth/revoke-refresh-token';
  static String forgetPassword = '/Auth/forget-password'; // ✅ ناقص
  static String verifyCode = '/Auth/verify-code'; // ✅ ناقص
  static String resetPassword = '/Auth/reset-password'; // ✅ ناقص

  // Account
  static String profile = '/account/profile';
  static String updateProfile = '/account/update-profile';
  static String changePassword = '/account/change-password';

  // Chat
  static String ask = '/api/Chat/ask'; // ✅ ناقص
  // أضف الـ endpoints دي
  static String predict = '/api/ML';
  static String predictionHistory = '/api/PredictionHistory';
  static String predictionHistoryWithStatus =
      '/api/PredictionHistory/with-status';
  static String predictionStatistics = '/api/PredictionHistory/statistics';
  static const String riskAssessment = '/api/RiskAssessment/assess';
}
