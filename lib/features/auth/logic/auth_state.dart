part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final AuthResponse user; // ✅ بدل token و refreshToken
  LoginSuccess({required this.user});
}

class RegisterSuccess extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class VerifyCodeSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
