import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';
import 'package:jenosize/data/repositories/auth_repository_impl.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      const LoginWithEmailRequest(email: '', password: ''),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepositoryImpl.loginWithEmail', () {
    final request = const LoginWithEmailRequest(
      email: 'test@example.com',
      password: 'password123',
    );

    test('should return Auth entity on successful login', () async {
      final auth = Auth(
        accessToken: 'token123',
        refreshToken: 'secretXYZ',
        expiredAt: DateTime.parse('2025-01-01T00:00:00Z'),
      );

      when(
        () =>
            mockRemoteDataSource.loginWithEmail(request: any(named: 'request')),
      ).thenAnswer((_) async => auth);

      final result = await repository.loginWithEmail(request: request);

      expect(result, isA<Success<Auth>>());
      expect((result as Success<Auth>).value, isA<Auth>());
      expect(result.value.accessToken, equals(auth.accessToken));
      expect(result.value.refreshToken, equals(auth.refreshToken));
      expect(result.value.expiredAt, equals(auth.expiredAt));

      verify(
        () =>
            mockRemoteDataSource.loginWithEmail(request: any(named: 'request')),
      ).called(1);
    });

    test('should propagate error if remote data source throws', () async {
      final exception = Exception('Login failed');

      when(
        () =>
            mockRemoteDataSource.loginWithEmail(request: any(named: 'request')),
      ).thenAnswer((_) async => throw exception);

      final result = await repository.loginWithEmail(request: request);

      expect(result, isA<Failure>());
      verify(
        () =>
            mockRemoteDataSource.loginWithEmail(request: any(named: 'request')),
      ).called(1);
    });
  });
}
