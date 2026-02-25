import 'package:app_template/data/models/user.dart';
import 'package:app_template/data/models/version_status.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/ui/screens/splash/cubit/splash_screen_cubit.dart';
import 'package:app_template/ui/screens/splash/cubit/splash_screen_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockSplashScreenUseCase mockUseCase;
  late MockSessionCubit mockSessionCubit;
  late SplashScreenCubit cubit;

  setUp(() {
    mockUseCase = MockSplashScreenUseCase();
    mockSessionCubit = MockSessionCubit();
    cubit = SplashScreenCubit(
      sessionCubit: mockSessionCubit,
      useCase: mockUseCase,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  group('SplashScreenCubit', () {
    test('initial state is SplashScreenState.initial', () {
      expect(cubit.state, equals(const SplashScreenState()));
    });

    blocTest<SplashScreenCubit, SplashScreenState>(
      'emits newVersionAvailable state when getVersionStatus returns an update',
      build: () {
        when(() => mockUseCase.getVersionStatus()).thenAnswer(
          (_) async => const VersionStatus(
            localVersion: '1.0.0',
            storeVersion: '1.0.1',
            appStoreLink: 'http://appstore.link',
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        verify(() => mockUseCase.getVersionStatus()).called(1);
      },
      expect: () => [
        const SplashScreenState(
          status: SplashScreenStatus.newVersionAvailable,
          appStoreLink: 'http://appstore.link',
          storeVersion: '1.0.1',
        ),
      ],
    );

    blocTest<SplashScreenCubit, SplashScreenState>(
      'emits authenticated state when no update available and session is authenticated',
      build: () {
        when(
          () => mockUseCase.getVersionStatus(),
        ).thenAnswer((_) async => null);

        when(() => mockUseCase.getUserSession()).thenAnswer((_) async {
          return const Success(User());
        });

        return cubit;
      },
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        verify(() => mockUseCase.getVersionStatus()).called(1);
        verify(() => mockUseCase.getUserSession()).called(1);
      },
      expect: () => [
        const SplashScreenState(
          status: SplashScreenStatus.authenticated,
          appStoreLink: null,
          storeVersion: null,
        ),
      ],
    );

    blocTest<SplashScreenCubit, SplashScreenState>(
      'emits unauthenticated state when no update available and session is not authenticated',
      build: () {
        when(
          () => mockUseCase.getVersionStatus(),
        ).thenAnswer((_) async => null);

        when(() => mockUseCase.getUserSession()).thenAnswer((_) async {
          return const Failure(AppError(message: 'error'));
        });

        return cubit;
      },
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        verify(() => mockUseCase.getVersionStatus()).called(1);
        verify(() => mockUseCase.getUserSession()).called(1);
      },
      expect: () => [
        const SplashScreenState(
          status: SplashScreenStatus.unauthenticated,
          appStoreLink: null,
          storeVersion: null,
        ),
      ],
    );
  });
}
