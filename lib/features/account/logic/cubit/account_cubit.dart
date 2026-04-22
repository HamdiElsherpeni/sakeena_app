import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/account/data/models/change_password_request.dart';
import 'package:sakeena_app/features/account/data/models/update_profile_request.dart';
import 'package:sakeena_app/features/account/data/models/user_profile_model.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepo _repo;

  AccountCubit(this._repo) : super(AccountInitial());

  UserProfileModel? user;

  Future<void> getProfile() async {
    emit(AccountLoading());
    try {
      final profile = await _repo.getProfile();
      if (isClosed) return;
      user = profile;
      emit(ProfileLoaded(profile));
    } on Failer catch (e) {
      if (isClosed) return;
      emit(AccountError(e.errorMessage));
    } catch (_) {
      if (isClosed) return;
      emit(AccountError('Something went wrong'));
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    emit(AccountLoading());
    try {
      final profile = await _repo.updateProfile(
        UpdateProfileRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
        ),
      );
      if (isClosed) return;
      user = profile;
      emit(ProfileUpdated(profile)); // ✅ state واحدة بس
    } on Failer catch (e) {
      if (isClosed) return;
      emit(AccountError(e.errorMessage));
    } catch (_) {
      if (isClosed) return;
      emit(AccountError('Something went wrong'));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(AccountLoading());
    try {
      await _repo.changePassword(
        ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      if (isClosed) return;
      emit(PasswordChanged());
    } on Failer catch (e) {
      if (isClosed) return;
      emit(AccountError(e.errorMessage));
    } catch (_) {
      if (isClosed) return;
      emit(AccountError('Something went wrong'));
    }
  }
}
