import 'package:sakeena_app/features/auth/data/models/login_request.dart';
import 'package:sakeena_app/features/auth/data/models/login_response_model.dart';
import 'package:sakeena_app/features/auth/data/models/register_request.dart';
import 'package:sakeena_app/features/auth/data/models/forgrt_pass_request.dart';
import 'package:sakeena_app/features/auth/data/models/verify_code_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/reset_pass_request_model.dart';
import 'package:sakeena_app/features/auth/data/models/refresh_token_request_model.dart';

abstract class AuthRepo {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<void> register(RegisterRequestModel request);
  Future<void> forgetPassword(ForgetPasswordRequestModel request);
  Future<void> verifyCode(VerifyCodeRequestModel request);
  Future<void> resetPassword(ResetPasswordRequestModel request);
  Future<LoginResponseModel> refreshToken(RefreshTokenRequestModel request);
  Future<void> revokeRefreshToken(RefreshTokenRequestModel request);
}
