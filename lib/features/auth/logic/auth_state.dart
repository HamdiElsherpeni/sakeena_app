abstract class AuthState {}

// البداية
class AuthInitial extends AuthState {}

// تحميل
class AuthLoading extends AuthState {}

// نجاح (فيه token)
class AuthSuccess extends AuthState {
  final String token;

  AuthSuccess(this.token);
}

// تسجيل الخروج
class AuthLoggedOut extends AuthState {}

// خطأ
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}