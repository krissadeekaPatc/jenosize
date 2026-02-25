import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_state.dart';

void main() {
  group('SplashScreenState', () {
    test(
      'initial state defaults to initial with no appStoreLink and storeVersion',
      () {
        const state = SplashScreenState();
        expect(state.status, SplashScreenStatus.initial);
        expect(state.appStoreLink, isNull);
        expect(state.storeVersion, isNull);
      },
    );

    test('copyWith returns a new state with updated fields', () {
      const state = SplashScreenState();
      final updatedState = state.copyWith(
        status: SplashScreenStatus.authenticated,
        appStoreLink: 'http://example.com',
        storeVersion: '1.2.3',
      );
      expect(updatedState.status, SplashScreenStatus.authenticated);
      expect(updatedState.appStoreLink, equals('http://example.com'));
      expect(updatedState.storeVersion, equals('1.2.3'));
    });

    test('authenticated returns state with authenticated status', () {
      const state = SplashScreenState();
      final updated = state.authenticated();
      expect(updated.status, SplashScreenStatus.authenticated);
    });

    test('unauthenticated returns state with unauthenticated status', () {
      const state = SplashScreenState();
      final updated = state.unauthenticated();
      expect(updated.status, SplashScreenStatus.unauthenticated);
    });

    test('copyWith returns the same state when no arguments are provided', () {
      const state = SplashScreenState(
        status: SplashScreenStatus.initial,
        appStoreLink: 'link',
        storeVersion: 'version',
      );
      final copy = state.copyWith();
      expect(copy, equals(state));
    });
  });
}
