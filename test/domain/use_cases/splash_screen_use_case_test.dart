import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/use_cases/splash_use_case.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late SplashScreenUseCase useCase;
  late MockTokenVault mockTokenVault;
  late MockUserRepository mockUserRepository;
  late MockSessionCubit mockSessionCubit;

  final mockUser = const User(
    id: 'user_123',
    firstName: 'Krissadeeka',
    lastName: 'Patchantakeereesaakun',
  );

  setUp(() {
    mockTokenVault = MockTokenVault();
    mockUserRepository = MockUserRepository();
    mockSessionCubit = MockSessionCubit();

    useCase = SplashScreenUseCase(
      tokenVault: mockTokenVault,
      userRepository: mockUserRepository,
      sessionCubit: mockSessionCubit,
    );

    when(() => mockSessionCubit.state).thenReturn(const SessionState());
  });

  /*
   * SplashScreenUseCase Test Cases:
   * 1. No Token: ตรวจสอบว่าถ้าไม่มี Access Token ใน Vault จะต้องคืนค่า Failure กลับไปทันที
   * 2. Cache Hit: ตรวจสอบว่าถ้ามี User ใน SessionCubit อยู่แล้ว จะต้องคืนค่า User นั้นโดยไม่เรียก API
   * 3. Fetch Success: ตรวจสอบว่าถ้าไม่มี User ใน Cache จะต้องดึงผ่าน UserRepository และบันทึกลง SessionCubit เมื่อสำเร็จ
   * 4. Fetch Failure: ตรวจสอบว่าถ้าเรียก API ล้มเหลว จะต้องคืนค่า Failure กลับไป
   */
  group('SplashScreenUseCase', () {
    test('returns Failure when access token is not found', () async {
      when(
        () => mockTokenVault.hasAccessToken(),
      ).thenAnswer((_) async => false);

      final result = await useCase.getUserSession();

      expect(result, isA<Failure>());
      verifyNever(() => mockUserRepository.getProfile());
    });

    test(
      'returns Success with user from SessionCubit when cache exists',
      () async {
        when(
          () => mockTokenVault.hasAccessToken(),
        ).thenAnswer((_) async => true);
        when(
          () => mockSessionCubit.state,
        ).thenReturn(SessionState(user: mockUser));

        final result = await useCase.getUserSession();

        expect(result, Success(mockUser));
        verifyNever(() => mockUserRepository.getProfile());
      },
    );

    test(
      'fetches from repository and updates session when cache is empty',
      () async {
        when(
          () => mockTokenVault.hasAccessToken(),
        ).thenAnswer((_) async => true);
        when(() => mockSessionCubit.state).thenReturn(const SessionState());
        when(
          () => mockUserRepository.getProfile(),
        ).thenAnswer((_) async => Success(mockUser));

        when(() => mockSessionCubit.setUser(any())).thenReturn(null);

        final result = await useCase.getUserSession();

        expect(result, Success(mockUser));
        verify(() => mockUserRepository.getProfile()).called(1);
        verify(() => mockSessionCubit.setUser(mockUser)).called(1);
      },
    );

    test('returns Failure when repository fetch fails', () async {
      const error = AppError(message: 'Server Error');
      when(() => mockTokenVault.hasAccessToken()).thenAnswer((_) async => true);
      when(() => mockSessionCubit.state).thenReturn(const SessionState());
      when(
        () => mockUserRepository.getProfile(),
      ).thenAnswer((_) async => const Failure(error));

      final result = await useCase.getUserSession();

      expect(result, const Failure(error));
      verify(() => mockUserRepository.getProfile()).called(1);
      verifyNever(() => mockSessionCubit.setUser(any()));
    });
  });
}
