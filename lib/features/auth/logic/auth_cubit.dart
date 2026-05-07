import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/services/token_service.dart';
import 'package:sakeena_app/features/auth/data/models/auth_response.dart';
import 'package:sakeena_app/features/auth/data/models/login_request.dart';
import 'package:sakeena_app/features/auth/data/models/register_request.dart';
import 'package:sakeena_app/features/auth/data/models/forgrt_pass_request.dart';
import 'package:sakeena_app/features/auth/data/models/verify_code_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/reset_pass_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/refresh_token_request_model.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthInitial());

  AuthResponse? user;

  void _safeEmit(AuthState state) {
    if (!isClosed) emit(state);
  }

  // ─── Login ────────────────────────────────────────────────────────────────
  Future<void> login({required String email, required String password}) async {
    _safeEmit(AuthLoading());
    try {
      final response = await _repo.login(
        LoginRequestModel(email: email, password: password),
      );
      print('🟢 refreshTokenExpiration: ${response.refreshTokenExpiration}');
      await TokenService.saveTokens(
        token: response.token,
        refreshToken: response.refreshToken,
        refreshTokenExpiration: response.refreshTokenExpiration,
      );
      user = response;
      _safeEmit(LoginSuccess(user: response));
    } on Failer catch (e) {
      _safeEmit(AuthError(e.errorMessage));
    } catch (e) {
      _safeEmit(AuthError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  // ─── Register ─────────────────────────────────────────────────────────────
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    _safeEmit(AuthLoading());
    try {
      await _repo.register(
        RegisterRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );
      _safeEmit(RegisterSuccess());
    } on Failer catch (e) {
      _safeEmit(AuthError(e.errorMessage));
    } catch (e) {
      _safeEmit(AuthError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  // ─── Forget Password ──────────────────────────────────────────────────────
  Future<void> forgetPassword({required String email}) async {
    _safeEmit(AuthLoading());
    try {
      await _repo.forgetPassword(ForgetPasswordRequestModel(email: email));
      _safeEmit(ForgetPasswordSuccess());
    } on Failer catch (e) {
      _safeEmit(AuthError(e.errorMessage));
    } catch (e) {
      _safeEmit(AuthError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  // ─── Verify Code ──────────────────────────────────────────────────────────
  Future<void> verifyCode({required String email, required String code}) async {
    _safeEmit(AuthLoading());
    try {
      await _repo.verifyCode(VerifyCodeRequestModel(email: email, code: code));
      _safeEmit(VerifyCodeSuccess());
    } on Failer catch (e) {
      _safeEmit(AuthError(e.errorMessage));
    } catch (e) {
      _safeEmit(AuthError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  // ─── Reset Password ───────────────────────────────────────────────────────
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _safeEmit(AuthLoading());
    try {
      await _repo.resetPassword(
        ResetPasswordRequestModel(
          email: email,
          code: code,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );
      _safeEmit(ResetPasswordSuccess());
    } on Failer catch (e) {
      _safeEmit(AuthError(e.errorMessage));
    } catch (e) {
      _safeEmit(AuthError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  // ─── Logout ───────────────────────────────────────────────────────────────
  Future<void> logout() async {
    _safeEmit(AuthLoading());
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();

      await _repo.revokeRefreshToken(
        RefreshTokenRequestModel(
          token: token ?? '',
          refreshToken: refreshToken ?? '',
        ),
      );
    } catch (_) {
      // حتى لو الـ revoke فشل، امسح التوكنز وسجل خروج
    } finally {
      await TokenService.clearTokens();
      user = null;
      _safeEmit(LoggedOut());
    }
  }
}
