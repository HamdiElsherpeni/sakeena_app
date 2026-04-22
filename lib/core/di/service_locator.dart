import 'package:get_it/get_it.dart';
import 'package:sakeena_app/features/account/data/datasources/account_remote_datasource.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo_implement.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repo_implement.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ── Auth DataSources ───────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(),
  );

  // ── Auth Repositories ──────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthRemoteDatasource>()),
  );

  // ── Auth Cubits ────────────────────────────────────────────────────────────
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton<AccountRemoteDatasource>(
    () => AccountRemoteDatasource(),
  );
  getIt.registerLazySingleton<AccountRepo>(
    () => AccountRepoImpl(getIt<AccountRemoteDatasource>()),
  );
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt<AccountRepo>()));
}
