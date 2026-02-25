import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:jenosize/app/initializers/secure_storage_initializer.dart';
import 'package:jenosize/data/data_sources/auth_remote_data_source.dart';
import 'package:jenosize/data/data_sources/campaign_remote_data_source.dart';
import 'package:jenosize/data/data_sources/point_remote_data_source.dart';
import 'package:jenosize/data/data_sources/user_remote_data_source.dart';
import 'package:jenosize/data/repositories/auth_repository_impl.dart';
import 'package:jenosize/data/repositories/campaign_repository_impl.dart';
import 'package:jenosize/data/repositories/point_repository_impl.dart';
import 'package:jenosize/data/repositories/user_repository_impl.dart';
import 'package:jenosize/data/storages/app_storage_impl.dart';
import 'package:jenosize/data/storages/token_vault_impl.dart';
import 'package:jenosize/domain/repositories/auth_repository.dart';
import 'package:jenosize/domain/repositories/campaign_repository.dart';
import 'package:jenosize/domain/repositories/point_repository.dart';
import 'package:jenosize/domain/repositories/user_repository.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/domain/storages/secure_storage.dart';
import 'package:jenosize/domain/storages/token_vault.dart';
import 'package:jenosize/domain/use_cases/get_point_transaction_usecase.dart';
import 'package:jenosize/domain/use_cases/get_user_use_case.dart';
import 'package:jenosize/domain/use_cases/login_with_email_use_case.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/theme_mode_cubit.dart';
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

  final sessionCubit = SessionCubit(appStorage: storage);
  getIt.registerSingleton<SessionCubit>(sessionCubit);

  getIt.registerLazySingleton<AssetBundle>(() => rootBundle);

  /// Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(AuthRemoteDataSource(bundle: getIt())),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(UserRemoteDataSource(bundle: getIt())),
  );

  getIt.registerLazySingleton<CampaignRepository>(
    () => CampaignRepositoryImpl(
      CampaignRemoteDataSource(bundle: getIt()),
    ),
  );

  getIt.registerLazySingleton<PointRepository>(
    () => PointRepositoryImpl(PointRemoteDataSource(bundle: getIt())),
  );

  getIt.registerLazySingleton<GetPointTransactionsUseCase>(
    () => GetPointTransactionsUseCase(
      pointRepository: getIt(),
      sessionCubit: getIt(),
    ),
  );

  /// UseCases

  getIt.registerFactory<GetUserUseCase>(
    () => GetUserUseCase(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<LoginWithEmailUseCase>(
    () => LoginWithEmailUseCase(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}
