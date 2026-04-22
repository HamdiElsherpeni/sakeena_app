import 'package:sakeena_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sakeena_app/features/auth/data/models/auth_response.dart';
import 'package:sakeena_app/features/auth/data/models/login_request.dart';
import 'package:sakeena_app/features/auth/data/models/refresh_token_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/register_request.dart';
import 'package:sakeena_app/features/auth/data/models/forgrt_pass_request.dart';
import 'package:sakeena_app/features/auth/data/models/reset_pass_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/verify_code_request_model.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _remoteDataSource;

  AuthRepoImpl(this._remoteDataSource);

  @override
  Future<AuthResponse> login(LoginRequestModel request) async =>
      await _remoteDataSource.login(request);

  @override
  Future<void> register(RegisterRequestModel request) async =>
      await _remoteDataSource.register(request);

  @override
  Future<void> forgetPassword(ForgetPasswordRequestModel request) async =>
      await _remoteDataSource.forgetPassword(request);

  @override
  Future<void> verifyCode(VerifyCodeRequestModel request) async =>
      await _remoteDataSource.verifyCode(request);

  @override
  Future<void> resetPassword(ResetPasswordRequestModel request) async =>
      await _remoteDataSource.resetPassword(request);

  @override
  Future<AuthResponse> refreshToken(RefreshTokenRequestModel request) async =>
      await _remoteDataSource.refreshToken(request);

  @override
  Future<void> revokeRefreshToken(RefreshTokenRequestModel request) async =>
      await _remoteDataSource.revokeRefreshToken(request);
}
