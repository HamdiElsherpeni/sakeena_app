import 'package:get_it/get_it.dart';
import 'package:sakeena_app/core/network/api_client.dart';
import 'package:sakeena_app/core/network/api_services.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';
import 'package:sakeena_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(apiService: getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(datasource: getIt()));

  // Cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
