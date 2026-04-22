import 'package:sakeena_app/core/network/api_client.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import '../models/user_profile_model.dart';
import '../models/update_profile_request.dart';
import '../models/change_password_request.dart';

class AccountRemoteDatasource {
  // ─── Get Profile ──────────────────────────────────────────────────────────
  Future<UserProfileModel> getProfile() async {
    final response = await ApiClient.get(ApiEndpoints.profile);
    return UserProfileModel.fromJson(response);
  }

  // ─── Update Profile ───────────────────────────────────────────────────────
  Future<UserProfileModel> updateProfile(UpdateProfileRequest request) async {
    final response = await ApiClient.put(
      ApiEndpoints.updateProfile,
      data: request.toJson(),
    );
    return UserProfileModel.fromJson(response);
  }

  // ─── Change Password ──────────────────────────────────────────────────────
  Future<void> changePassword(ChangePasswordRequest request) async {
    await ApiClient.put(ApiEndpoints.changePassword, data: request.toJson());
  }
}
