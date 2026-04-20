import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import '../../../../core/errors/failer.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;

  AuthCubit(this._repo) : super(AuthInitial());

  // ✅ Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final response = await _repo.login(
        email: email,
        password: password,
      );

      emit(AuthSuccess(response.token));
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ✅ Register
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final response = await _repo.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      emit(AuthSuccess(response.token));
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  // ✅ Logout
  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await _repo.logout();
      emit(AuthLoggedOut());
    } on Failer catch (e) {
      emit(AuthError(e.errorMessage));
    } catch (e) {
      emit(AuthError('Logout failed'));
    }
  }
}