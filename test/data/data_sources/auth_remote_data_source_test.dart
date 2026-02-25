import 'package:app_template/data/data_sources/auth_remote_data_source.dart';
import 'package:app_template/data/models/auth.dart';
import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSource(mockApiClient);
  });

  group('AuthRemoteDataSource.loginWithEmail', () {
    const testPath = '/api/app/auth/credentials/signin';

    final testResponse = Response(
      statusCode: 200,
      requestOptions: RequestOptions(),
      data: {
        'data': {
          'accessToken': 'token123',
          'refreshToken': 'secretXYZ',
          'expiredAt': '2025-01-01T00:00:00.000Z',
        },
      },
    );

    final request = const LoginWithEmailRequest(
      email: 'test@example.com',
      password: 'password123',
    );

    test('should return Auth when API call is successful', () async {
      when(
        () => mockApiClient.post(testPath, data: request.toJson()),
      ).thenAnswer((_) async => testResponse);

      final result = await dataSource.loginWithEmail(request: request);

      expect(result, isA<Auth>());
      expect(result.accessToken, equals('token123'));
      expect(result.refreshToken, equals('secretXYZ'));
      expect(
        result.expiredAt,
        equals(DateTime.parse('2025-01-01T00:00:00.000Z')),
      );

      verify(
        () => mockApiClient.post(testPath, data: request.toJson()),
      ).called(1);
    });
  });
}
