import 'package:sakeena_app/core/network/api_client.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import '../models/login_request.dart';
import '../models/login_response_model.dart';
import '../models/register_request.dart';
import '../models/forgrt_pass_request.dart';
import '../models/verify_code_request_model.dart';
import '../models/reset_pass_request_model.dart';
import '../models/refresh_token_request_model.dart';

class AuthRemoteDatasource {
  // ─── Login ────────────────────────────────────────────────────────────────
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await ApiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response);
  }

  // ─── Register ─────────────────────────────────────────────────────────────
  Future<void> register(RegisterRequestModel request) async {
    await ApiClient.post(ApiEndpoints.register, data: request.toJson());
  }

  // ─── Forget Password ──────────────────────────────────────────────────────
  Future<void> forgetPassword(ForgetPasswordRequestModel request) async {
    await ApiClient.post(ApiEndpoints.forgetPassword, data: request.toJson());
  }

  // ─── Verify Code ──────────────────────────────────────────────────────────
  Future<void> verifyCode(VerifyCodeRequestModel request) async {
    await ApiClient.post(ApiEndpoints.verifyCode, data: request.toJson());
  }

  // ─── Reset Password ───────────────────────────────────────────────────────
  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    await ApiClient.post(ApiEndpoints.resetPassword, data: request.toJson());
  }

  // ─── Refresh Token ────────────────────────────────────────────────────────
  Future<LoginResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  ) async {
    final response = await ApiClient.post(
      ApiEndpoints.refresh,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response);
  }

  // ─── Revoke Token ─────────────────────────────────────────────────────────
  Future<void> revokeRefreshToken(RefreshTokenRequestModel request) async {
    await ApiClient.post(ApiEndpoints.revoke, data: request.toJson());
  }
}
