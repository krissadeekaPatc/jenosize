import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_cubit.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

class FakeLoginWithEmailRequest extends Fake implements LoginWithEmailRequest {}

class FakeAuth extends Fake implements Auth {}

void main() {
  late MockLoginWithEmailUseCase mockLoginUseCase;

  const testEmail = 'test@email.com';
  const testPassword = 'password123';
  final testError = const AppError();

  setUpAll(() {
    registerFallbackValue(FakeLoginWithEmailRequest());
  });

  setUp(() {
    mockLoginUseCase = MockLoginWithEmailUseCase();
  });

  /*
   * LoginScreenCubit Test Cases:
   * 1. Success Flow: ตรวจสอบการเปลี่ยน State ไปที่ loading() และ success() เมื่อ Login API สำเร็จ
   * 2. Failure Flow: ตรวจสอบการเปลี่ยน State ไปที่ loading() และ failure() พร้อมแนบ Error เมื่อ Login API ล้มเหลว
   * 3. Guard Condition (Loading Check): ตรวจสอบการดักจับไม่ให้เรียก UseCase ซ้ำ หาก State ปัจจุบันกำลัง loading() อยู่
   */
  group('LoginScreenCubit', () {
    blocTest<LoginScreenCubit, LoginScreenState>(
      'emits loading then success when login is successful',
      setUp: () {
        when(
          () => mockLoginUseCase.call(request: any(named: 'request')),
        ).thenAnswer((_) async => Success(FakeAuth()));
      },
      build: () => LoginScreenCubit(mockLoginUseCase),
      act: (cubit) => cubit.login(testEmail, testPassword),
      expect: () => [
        const LoginScreenState().loading(),
        const LoginScreenState().loading().success(),
      ],
      verify: (_) {
        verify(
          () => mockLoginUseCase.call(
            request: any(named: 'request', that: isA<LoginWithEmailRequest>()),
          ),
        ).called(1);
      },
    );

    blocTest<LoginScreenCubit, LoginScreenState>(
      'emits loading then failure when login fails',
      setUp: () {
        when(
          () => mockLoginUseCase.call(request: any(named: 'request')),
        ).thenAnswer((_) async => Failure(testError));
      },
      build: () => LoginScreenCubit(mockLoginUseCase),
      act: (cubit) => cubit.login(testEmail, testPassword),
      expect: () => [
        const LoginScreenState().loading(),
        const LoginScreenState().loading().failure(testError),
      ],
      verify: (_) {
        verify(
          () => mockLoginUseCase.call(
            request: any(named: 'request', that: isA<LoginWithEmailRequest>()),
          ),
        ).called(1);
      },
    );

    blocTest<LoginScreenCubit, LoginScreenState>(
      'does nothing when state is already loading (Guard condition)',
      build: () => LoginScreenCubit(mockLoginUseCase),
      seed: () => const LoginScreenState().loading(),
      act: (cubit) => cubit.login(testEmail, testPassword),
      expect: () => [],
      verify: (_) {
        verifyNever(
          () => mockLoginUseCase.call(request: any(named: 'request')),
        );
      },
    );
  });
}
