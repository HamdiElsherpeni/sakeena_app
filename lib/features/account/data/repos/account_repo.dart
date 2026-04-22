// ─── Abstract Repo ────────────────────────────────────────────────────────────
import 'package:sakeena_app/features/account/data/models/change_password_request.dart';
import 'package:sakeena_app/features/account/data/models/update_profile_request.dart';
import 'package:sakeena_app/features/account/data/models/user_profile_model.dart';

abstract class AccountRepo {
  Future<UserProfileModel> getProfile();
  Future<UserProfileModel> updateProfile(UpdateProfileRequest request);
  Future<void> changePassword(ChangePasswordRequest request);
}
