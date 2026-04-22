import 'package:sakeena_app/features/account/data/models/user_profile_model.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class ProfileLoaded extends AccountState {
  final UserProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileUpdated extends AccountState {
  final UserProfileModel profile;
  ProfileUpdated(this.profile);
}

class PasswordChanged extends AccountState {}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}
