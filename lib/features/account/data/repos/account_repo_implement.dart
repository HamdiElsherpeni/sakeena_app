// ─── Implementation ───────────────────────────────────────────────────────────
import '../datasources/account_remote_datasource.dart';
import '../models/user_profile_model.dart';
import '../models/update_profile_request.dart';
import '../models/change_password_request.dart';
import 'account_repo.dart';

class AccountRepoImpl implements AccountRepo {
  final AccountRemoteDatasource _datasource;

  AccountRepoImpl(this._datasource);

  @override
  Future<UserProfileModel> getProfile() => _datasource.getProfile();

  @override
  Future<UserProfileModel> updateProfile(UpdateProfileRequest request) =>
      _datasource.updateProfile(request);

  @override
  Future<void> changePassword(ChangePasswordRequest request) =>
      _datasource.changePassword(request);
}
