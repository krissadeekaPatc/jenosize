import 'package:app_template/data/enums/user_gender.dart';
import 'package:app_template/data/models/user.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/use_cases/splash_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockTokenVault mockTokenVault;
  late MockStoreVersionRepository mockStoreVersionRepository;
  late MockUserRepository mockUserRepository;
  late SplashScreenUseCase useCase;

  setUp(() {
    mockTokenVault = MockTokenVault();
    mockStoreVersionRepository = MockStoreVersionRepository();
    mockUserRepository = MockUserRepository();
    useCase = SplashScreenUseCase(
      tokenVault: mockTokenVault,
      storeVersionRepository: mockStoreVersionRepository,
      userRepository: mockUserRepository,
    );
  });
  group('SplashScreenUseCase', () {
    test(
      'getUserSession returns error when tokenVault.hasAccessToken() returns false',
      () async {
        when(
          () => mockTokenVault.hasAccessToken(),
        ).thenAnswer((_) async => false);

        final result = await useCase.getUserSession();

        expect(
          result,
          const Failure<User>(AppError(message: 'Access token not found')),
        );
        verify(() => mockTokenVault.hasAccessToken()).called(1);
      },
    );

    test(
      'getUserSession returns user when userRepository.me() succeeds',
      () async {
        final dummyUser = const User(
          id: '1',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          gender: UserGender.male,
        );
        when(
          () => mockTokenVault.hasAccessToken(),
        ).thenAnswer((_) async => true);
        when(
          () => mockUserRepository.me(),
        ).thenAnswer((_) async => Success<User>(dummyUser));

        final result = await useCase.getUserSession();

        expect(result, Success<User>(dummyUser));
        verify(() => mockUserRepository.me()).called(1);
      },
    );

    test(
      'getUserSession returns error when userRepository.me() throws error with status 401',
      () async {
        final appError = const AppError(
          message: 'Unauthorized',
          statusCode: 401,
        );
        when(
          () => mockTokenVault.hasAccessToken(),
        ).thenAnswer((_) async => true);
        when(
          () => mockUserRepository.me(),
        ).thenAnswer((_) async => Failure(appError));

        final result = await useCase.getUserSession();

        expect(result, Failure(appError));
        verify(() => mockUserRepository.me()).called(1);
      },
    );
  });
}
