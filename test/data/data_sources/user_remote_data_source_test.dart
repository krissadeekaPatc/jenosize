import 'package:jenosize/data/data_sources/user_remote_data_source.dart';
import 'package:jenosize/data/enums/user_gender.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late UserRemoteDataSource dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = const UserRemoteDataSource();
  });

  group('UserRemoteDataSource.me', () {
    test('returns a User when API call is successful', () async {
      const testPath = '/api/user/me';

      final testResponse = Response(
        statusCode: 200,
        requestOptions: RequestOptions(),
        data: {
          'data': {
            'id': '1',
            'firstName': 'John',
            'lastName': 'Doe',
            'email': 'john@example.com',
            'gender': 'Male',
          },
        },
      );

      when(
        () => mockApiClient.get(testPath),
      ).thenAnswer((_) async => testResponse);

      final user = await dataSource.getProfile();

      expect(user, isA<User>());
      expect(user.id, equals('1'));
      expect(user.firstName, equals('John'));
      expect(user.lastName, equals('Doe'));
      expect(user.email, equals('john@example.com'));
      expect(user.gender, equals(UserGender.male));

      verify(() => mockApiClient.get(testPath)).called(1);
    });
  });
}
