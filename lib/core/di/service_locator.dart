import 'package:get_it/get_it.dart';
import 'package:sakeena_app/features/account/data/datasources/account_remote_datasource.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo_implement.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repo_implement.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/smart_acan/data/data_source/scan_remote_datasource.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo_impl.dart';
import 'package:sakeena_app/features/smart_acan/logic/cubit/scan_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ── Auth ───────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthRemoteDatasource>()),
  );

  // ✅ Singleton مش Factory عشان الـ user يفضل محفوظ
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

  // ── Account ────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AccountRemoteDatasource>(
    () => AccountRemoteDatasource(),
  );
  getIt.registerLazySingleton<AccountRepo>(
    () => AccountRepoImpl(getIt<AccountRemoteDatasource>()),
  );
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt<AccountRepo>()));
  getIt.registerLazySingleton<ScanRemoteDatasource>(
    () => ScanRemoteDatasource(),
  );
  getIt.registerLazySingleton<ScanRepo>(
    () => ScanRepoImpl(getIt<ScanRemoteDatasource>()),
  );
  getIt.registerFactory<ScanCubit>(() => ScanCubit(getIt<ScanRepo>()));
}
