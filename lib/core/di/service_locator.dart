import 'package:get_it/get_it.dart';
import 'package:sakeena_app/features/account/data/datasources/account_remote_datasource.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo.dart';
import 'package:sakeena_app/features/account/data/repos/account_repo_implement.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repo_implement.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/chat/data/datasources/base_chat_datasource.dart';
import 'package:sakeena_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:sakeena_app/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:sakeena_app/features/chat/data/services/gemini_service.dart';
import 'package:sakeena_app/features/chat/data/services/stt_service.dart';
import 'package:sakeena_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:sakeena_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';
import 'package:sakeena_app/features/smart_acan/data/data_source/scan_remote_datasource.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo_impl.dart';
import 'package:sakeena_app/features/smart_acan/logic/cubit/scan_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<GeminiService>(() => GeminiService());
  getIt.registerLazySingleton<SpeechToTextService>(() => SpeechToTextService());
  getIt.registerLazySingleton<BaseChatDataSource>(
    () => ChatRemoteDataSource(getIt<GeminiService>()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepoImpl(getIt<BaseChatDataSource>()),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<ChatRepository>()),
  );
  getIt.registerFactory<SendMessageCubit>(
    () => SendMessageCubit(
      getIt<SendMessageUseCase>(),
      getIt<SpeechToTextService>(),
    ),
  );
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
