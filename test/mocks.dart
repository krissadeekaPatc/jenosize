import 'package:jenosize/data/data_sources/auth_remote_data_source.dart';
import 'package:jenosize/data/data_sources/user_remote_data_source.dart';
import 'package:jenosize/domain/api_client/api_client.dart';
import 'package:jenosize/domain/repositories/auth_repository.dart';
import 'package:jenosize/domain/repositories/store_version_repository.dart';
import 'package:jenosize/domain/repositories/user_repository.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/domain/storages/secure_storage.dart';
import 'package:jenosize/domain/storages/token_vault.dart';
import 'package:jenosize/domain/use_cases/get_user_use_case.dart';
import 'package:jenosize/domain/use_cases/login_with_email_use_case.dart';
import 'package:jenosize/domain/use_cases/splash_use_case.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockAppStorage extends Mock implements AppStorage {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockDio extends Mock implements Dio {}

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockLoginWithEmailUseCase extends Mock implements LoginWithEmailUseCase {}

class MockSecureStorage extends Mock implements SecureStorage {}

class MockSessionCubit extends Mock implements SessionCubit {}

class MockSplashScreenUseCase extends Mock implements SplashScreenUseCase {}

class MockStoreVersionRepository extends Mock
    implements StoreVersionRepository {}

class MockTokenVault extends Mock implements TokenVault {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserRepository extends Mock implements UserRepository {}
