import 'package:app_template/app/initializers/api_client_initializer.dart';
import 'package:app_template/app/initializers/secure_storage_initializer.dart';
import 'package:app_template/data/data_sources/auth_remote_data_source.dart';
import 'package:app_template/data/data_sources/health_local_data_source.dart';
import 'package:app_template/data/data_sources/store_version_remote_data_source.dart';
import 'package:app_template/data/data_sources/user_remote_data_source.dart';
import 'package:app_template/data/repositories/auth_repository_impl.dart';
import 'package:app_template/data/repositories/health_repository_impl.dart';
import 'package:app_template/data/repositories/store_version_repository_impl.dart';
import 'package:app_template/data/repositories/user_repository_impl.dart';
import 'package:app_template/data/storages/app_storage_impl.dart';
import 'package:app_template/data/storages/token_vault_impl.dart';
import 'package:app_template/domain/repositories/auth_repository.dart';
import 'package:app_template/domain/repositories/health_repository.dart';
import 'package:app_template/domain/repositories/store_version_repository.dart';
import 'package:app_template/domain/repositories/user_repository.dart';
import 'package:app_template/domain/storages/app_storage.dart';
import 'package:app_template/domain/storages/secure_storage.dart';
import 'package:app_template/domain/storages/token_vault.dart';
import 'package:app_template/domain/use_cases/calculate_body_age_use_case.dart';
import 'package:app_template/domain/use_cases/get_user_use_case.dart';
import 'package:app_template/domain/use_cases/login_with_email_use_case.dart';
import 'package:app_template/domain/use_cases/sync_and_calculate_body_age_use_case.dart';
import 'package:app_template/ui/cubits/app_language_cubit.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:app_template/ui/cubits/theme_mode_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final storage = AppStorageImpl(sharedPrefs);
  getIt.registerSingleton<AppStorage>(storage);

  final secureStorage = await initializeSecureStorage(storage);
  getIt.registerSingleton<SecureStorage>(secureStorage);

  final tokenVault = TokenVaultImpl(secureStorage);
  getIt.registerSingleton<TokenVault>(tokenVault);

  final themeModeCubit = ThemeModeCubit(storage);
  getIt.registerSingleton<ThemeModeCubit>(themeModeCubit);
  await themeModeCubit.initialize();

  final appLanguageCubit = AppLanguageCubit(storage);
  getIt.registerSingleton<AppLanguageCubit>(appLanguageCubit);
  await appLanguageCubit.initialize();

  final sessionCubit = SessionCubit();
  getIt.registerSingleton<SessionCubit>(sessionCubit);

  final apiClient = initializeApiClient(
    tokenVault: tokenVault,
    appLanguageCubit: appLanguageCubit,
  );

  final externalApiClient = initializeExternalApiClient();

  /// Repositories

  getIt.registerLazySingleton<StoreVersionRepository>(
    () => StoreVersionRepositoryImpl(
      StoreVersionRemoteDataSource(externalApiClient),
    ),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(AuthRemoteDataSource(apiClient)),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(UserRemoteDataSource(apiClient)),
  );

  getIt.registerSingleton<HealthRepository>(
    HealthRepositoryImpl(
      HealthLocalDataSource(),
    ),
  );

  /// UseCases

  getIt.registerFactory<GetUserUseCase>(
    () => GetUserUseCase(sessionCubit: sessionCubit, userRepository: getIt()),
  );
  getIt.registerFactory<LoginWithEmailUseCase>(
    () => LoginWithEmailUseCase(
      sessionCubit: sessionCubit,
      authRepository: getIt(),
      getUserUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CalculateBodyAgeUseCase>(
    () => const CalculateBodyAgeUseCase(),
  );

  getIt.registerFactory<SyncAndCalculateBodyAgeUseCase>(
    () => SyncAndCalculateBodyAgeUseCase(
      healthRepository: getIt(),
      calculateBodyAgeUseCase: getIt(),
    ),
  );
}
