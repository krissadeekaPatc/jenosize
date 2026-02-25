import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/ui/screens/login/cubit/login_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreenState', () {
    test('initial state defaults to initial status with no error', () {
      const state = LoginScreenState();
      expect(state.status, equals(LoginScreenStatus.initial));
      expect(state.error, isNull);
    });

    test('loading() returns a state with loading status', () {
      const state = LoginScreenState();
      final loadingState = state.loading();
      expect(loadingState.status, equals(LoginScreenStatus.loading));
      expect(loadingState.error, isNull);
    });

    test('ready() returns a state with ready status', () {
      const state = LoginScreenState();
      final readyState = state.ready();
      expect(readyState.status, equals(LoginScreenStatus.ready));
      expect(readyState.error, isNull);
    });

    test('success() returns a state with success status', () {
      const state = LoginScreenState();
      final successState = state.success();
      expect(successState.status, equals(LoginScreenStatus.success));
      expect(successState.error, isNull);
    });

    test(
      'failure() returns a state with failure status and sets the error',
      () {
        const state = LoginScreenState();
        const error = AppError(message: 'Test error');
        final failureState = state.failure(error);
        expect(failureState.status, equals(LoginScreenStatus.failure));
        expect(failureState.error, equals(error));
      },
    );

    test('copyWith updates state properties correctly', () {
      const state = LoginScreenState();
      const error = AppError(message: 'Updated error');
      final updatedState = state.copyWith(
        status: LoginScreenStatus.success,
        error: error,
      );
      expect(updatedState.status, equals(LoginScreenStatus.success));
      expect(updatedState.error, equals(error));
    });

    test('copyWith returns the same state when no arguments provided', () {
      const state = LoginScreenState(
        status: LoginScreenStatus.initial,
        error: null,
      );
      final copiedState = state.copyWith();
      expect(copiedState, equals(state));
    });

    test('isLoading getter returns true only for loading status', () {
      expect(LoginScreenStatus.loading.isLoading, isTrue);
      expect(LoginScreenStatus.initial.isLoading, isFalse);
      expect(LoginScreenStatus.ready.isLoading, isFalse);
      expect(LoginScreenStatus.success.isLoading, isFalse);
      expect(LoginScreenStatus.failure.isLoading, isFalse);
    });
  });
}
