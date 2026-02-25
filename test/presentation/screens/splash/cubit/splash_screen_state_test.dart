import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_state.dart';

void main() {
  /*
   * SplashScreenState Test Cases:
   * 1. Value Equality: ทดสอบว่า Equatable ทำงานถูกต้อง (Object สองตัวที่มีค่าเท่ากัน ถือว่าเท่ากัน)
   * 2. Props: ทดสอบว่า getter `props` ดึงค่า status ออกมาถูกต้อง
   * 3. copyWith: ทดสอบการสร้าง State ใหม่โดยเปลี่ยนแค่ status และการดึงค่าเดิมมาใช้ถ้าไม่ส่งค่าเข้ามา
   * 4. Helper Methods: 
   * - authenticated(): ทดสอบว่าเปลี่ยน status เป็น authenticated ได้ถูกต้อง
   * - unauthenticated(): ทดสอบว่าเปลี่ยน status เป็น unauthenticated ได้ถูกต้อง
   */
  group('SplashScreenState', () {
    test('supports value equality', () {
      expect(
        const SplashScreenState(),
        equals(const SplashScreenState()),
      );

      expect(
        const SplashScreenState(status: SplashScreenStatus.authenticated),
        isNot(
          equals(const SplashScreenState(status: SplashScreenStatus.initial)),
        ),
      );
    });

    test('props are correct', () {
      expect(
        const SplashScreenState(status: SplashScreenStatus.initial).props,
        equals([SplashScreenStatus.initial]),
      );

      expect(
        const SplashScreenState(
          status: SplashScreenStatus.unauthenticated,
        ).props,
        equals([SplashScreenStatus.unauthenticated]),
      );
    });

    group('copyWith', () {
      test('returns same object with updated status', () {
        final state = const SplashScreenState();
        final newState = state.copyWith(
          status: SplashScreenStatus.authenticated,
        );

        expect(newState.status, equals(SplashScreenStatus.authenticated));
      });

      test('returns same object when no arguments are provided', () {
        final state = const SplashScreenState(
          status: SplashScreenStatus.authenticated,
        );
        final newState = state.copyWith();

        expect(newState.status, equals(SplashScreenStatus.authenticated));
      });
    });

    group('Helper Methods', () {
      test('authenticated() changes status to authenticated', () {
        final state = const SplashScreenState().authenticated();

        expect(state.status, equals(SplashScreenStatus.authenticated));
      });

      test('unauthenticated() changes status to unauthenticated', () {
        final state = const SplashScreenState().unauthenticated();

        expect(state.status, equals(SplashScreenStatus.unauthenticated));
      });
    });
  });
}
