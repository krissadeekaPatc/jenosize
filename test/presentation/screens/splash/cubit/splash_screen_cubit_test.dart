import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_cubit.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

class FakeUser extends Fake implements User {}

void main() {
  late MockSessionCubit mockSessionCubit;
  late MockSplashScreenUseCase mockUseCase;

  const testError = AppError();

  setUp(() {
    mockSessionCubit = MockSessionCubit();
    mockUseCase = MockSplashScreenUseCase();
  });

  /*
   * SplashScreenCubit Test Cases:
   * 1. Authenticated Flow: ตรวจสอบเมื่อดึงข้อมูล Session สำเร็จ (Success) State จะต้องเปลี่ยนเป็น authenticated
   * 2. Unauthenticated Flow: ตรวจสอบเมื่อดึงข้อมูล Session ล้มเหลวหรือไม่พบข้อมูล (Failure) State จะต้องเปลี่ยนเป็น unauthenticated
   */
  group('SplashScreenCubit', () {
    blocTest<SplashScreenCubit, SplashScreenState>(
      'emits authenticated when useCase returns Success',
      setUp: () {
        when(() => mockUseCase.getUserSession()).thenAnswer(
          (_) async => Success(FakeUser()),
        );
      },
      build: () => SplashScreenCubit(
        sessionCubit: mockSessionCubit,
        useCase: mockUseCase,
      ),
      act: (cubit) => cubit.initialize(),
      expect: () => [
        const SplashScreenState().authenticated(),
      ],
      verify: (_) {
        verify(() => mockUseCase.getUserSession()).called(1);
      },
    );

    blocTest<SplashScreenCubit, SplashScreenState>(
      'emits unauthenticated when useCase returns Failure',
      setUp: () {
        when(() => mockUseCase.getUserSession()).thenAnswer(
          (_) async => const Failure(testError),
        );
      },
      build: () => SplashScreenCubit(
        sessionCubit: mockSessionCubit,
        useCase: mockUseCase,
      ),
      act: (cubit) => cubit.initialize(),
      expect: () => [
        const SplashScreenState().unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockUseCase.getUserSession()).called(1);
      },
    );
  });
}
