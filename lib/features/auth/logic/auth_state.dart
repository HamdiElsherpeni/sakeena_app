part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// ✅ Login و Refresh بيرجعوا token
class LoginSuccess extends AuthState {
  final String token;
  final String refreshToken;
  LoginSuccess({required this.token, required this.refreshToken});
}

// ✅ Register/ForgetPassword/VerifyCode/ResetPassword مفيهاش data
class RegisterSuccess extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class VerifyCodeSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
