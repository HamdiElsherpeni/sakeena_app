import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
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

  // ─── Login ────────────────────────────────────────────────────────────────
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await _repo.login(
        LoginRequestModel(email: email, password: password),
      );
      await TokenService.saveTokens(
        token: response.token,
        refreshToken: response.refreshToken,
      );
      user = response;
      emit(LoginSuccess(user: response));
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ─── Register ─────────────────────────────────────────────────────────────
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _repo.register(
        RegisterRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );
      emit(RegisterSuccess());
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ─── Forget Password ──────────────────────────────────────────────────────
  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await _repo.forgetPassword(ForgetPasswordRequestModel(email: email));
      emit(ForgetPasswordSuccess());
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ─── Verify Code ──────────────────────────────────────────────────────────
  Future<void> verifyCode({required String email, required String code}) async {
    emit(AuthLoading());
    try {
      await _repo.verifyCode(VerifyCodeRequestModel(email: email, code: code));
      emit(VerifyCodeSuccess());
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ─── Reset Password ───────────────────────────────────────────────────────
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      await _repo.resetPassword(
        ResetPasswordRequestModel(
          email: email,
          code: code,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );
      emit(ResetPasswordSuccess());
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ─── Logout ───────────────────────────────────────────────────────────────
  // ─── Logout ───────────────────────────────────────────────────────────────
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final token = await TokenService.getToken();
      final refreshToken = await TokenService.getRefreshToken();

      await _repo.revokeRefreshToken(
        RefreshTokenRequestModel(
          token: token ?? '',
          refreshToken: refreshToken ?? '',
        ),
      );
      await TokenService.clearTokens();
      user = null;
      emit(LoggedOut());
    } catch (e) {
      await TokenService.clearTokens();
      user = null;
      emit(LoggedOut());
    } finally {
      Future.microtask(() => getIt.resetLazySingleton<AuthCubit>());
    }
  }
}
