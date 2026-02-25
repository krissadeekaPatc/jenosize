import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_state.dart';

void main() {
  const testError = AppError();

  /*
   * LoginScreenState Test Cases:
   * 1. Value Equality: ทดสอบว่า Equatable ทำงานถูกต้อง (State ที่มีค่าเท่ากัน ถือว่าเป็น Object เดียวกัน)
   * 2. Props: ทดสอบว่า getter `props` ส่งคืนค่า `status` และ `error` ออกมาถูกต้องสำหรับให้ Equatable ใช้เปรียบเทียบ
   * 3. isLoading Getter: ทดสอบว่า get isLoading จะคืนค่า true เฉพาะตอนที่ status เป็น loading เท่านั้น
   * 4. copyWith: ทดสอบการโคลน State และเปลี่ยนเฉพาะค่าที่ส่งเข้าไป (เช่น เปลี่ยน status หรือเปลี่ยน error)
   * 5. Helper Methods: 
   * - loading(): ทดสอบว่าเปลี่ยนสถานะเป็น loading ได้ถูกต้อง
   * - success(): ทดสอบว่าเปลี่ยนสถานะเป็น success ได้ถูกต้อง
   * - failure(): ทดสอบว่าเปลี่ยนสถานะเป็น failure พร้อมแนบ AppError เข้าไปได้ถูกต้อง
   */
  group('LoginScreenState', () {
    test('supports value equality', () {
      expect(
        const LoginScreenState(),
        equals(const LoginScreenState()),
      );

      expect(
        const LoginScreenState(status: LoginScreenStatus.loading),
        isNot(
          equals(const LoginScreenState(status: LoginScreenStatus.initial)),
        ),
      );
    });

    test('props are correct', () {
      expect(
        const LoginScreenState(
          status: LoginScreenStatus.initial,
          error: null,
        ).props,
        equals([LoginScreenStatus.initial, null]),
      );

      expect(
        const LoginScreenState(
          status: LoginScreenStatus.failure,
          error: testError,
        ).props,
        equals([LoginScreenStatus.failure, testError]),
      );
    });

    group('isLoading', () {
      test('returns true when status is loading', () {
        expect(
          const LoginScreenState(status: LoginScreenStatus.loading).isLoading,
          isTrue,
        );
      });

      test('returns false when status is not loading', () {
        expect(
          const LoginScreenState(status: LoginScreenStatus.initial).isLoading,
          isFalse,
        );
        expect(
          const LoginScreenState(status: LoginScreenStatus.success).isLoading,
          isFalse,
        );
        expect(
          const LoginScreenState(status: LoginScreenStatus.failure).isLoading,
          isFalse,
        );
      });
    });

    group('copyWith', () {
      test('returns same object with updated status', () {
        final state = const LoginScreenState();
        final newState = state.copyWith(status: LoginScreenStatus.success);

        expect(newState.status, equals(LoginScreenStatus.success));
        expect(newState.error, isNull);
      });

      test('returns object with updated error', () {
        final state = const LoginScreenState(status: LoginScreenStatus.failure);
        final newState = state.copyWith(error: testError);

        expect(newState.status, equals(LoginScreenStatus.failure));
        expect(newState.error, equals(testError));
      });
    });

    group('Helper Methods', () {
      test('loading() changes status to loading', () {
        final state = const LoginScreenState().loading();

        expect(state.status, equals(LoginScreenStatus.loading));
        expect(state.error, isNull);
      });

      test('success() changes status to success', () {
        final state = const LoginScreenState().success();

        expect(state.status, equals(LoginScreenStatus.success));
        expect(state.error, isNull);
      });

      test('failure() changes status to failure and assigns error', () {
        final state = const LoginScreenState().failure(testError);

        expect(state.status, equals(LoginScreenStatus.failure));
        expect(state.error, equals(testError));
      });
    });
  });
}
