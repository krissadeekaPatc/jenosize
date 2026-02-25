import 'package:jenosize/data/enums/user_gender.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/data/repositories/user_repository_impl.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(mockRemoteDataSource);
  });

  group('UserRepositoryImpl.me', () {
    final user = const User(
      id: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      gender: UserGender.male,
    );

    test(
      'should return a `User` when remote data source returns a `User`',
      () async {
        when(
          () => mockRemoteDataSource.getProfile(),
        ).thenAnswer((_) async => user);

        final result = await repository.getProfile();

        expect(result, isA<Success<User>>());
        expect((result as Success<User>).value, isA<User>());
        expect(result.value.id, equals(user.id));
        expect(result.value.firstName, equals(user.firstName));
        expect(result.value.lastName, equals(user.lastName));
        expect(result.value.email, equals(user.email));
        expect(result.value.gender, equals(UserGender.male));

        verify(() => mockRemoteDataSource.getProfile()).called(1);
      },
    );

    test(
      'should propagate error when remote data source throws an exception',
      () async {
        final exception = Exception('Failed to fetch user');
        when(
          () => mockRemoteDataSource.getProfile(),
        ).thenAnswer((_) async => throw exception);

        final result = await repository.getProfile();

        expect(result, isA<Failure>());
        verify(() => mockRemoteDataSource.getProfile()).called(1);
      },
    );
  });
}
