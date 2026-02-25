import 'package:jenosize/data/enums/user_gender.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('fromJson should correctly parse valid JSON', () {
      final jsonMap = <String, dynamic>{
        'id': '123',
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john@example.com',
        'gender': 'Male',
      };

      final user = User.fromJson(jsonMap);

      expect(user.id, equals('123'));
      expect(user.firstName, equals('John'));
      expect(user.lastName, equals('Doe'));
      expect(user.email, equals('john@example.com'));
      expect(user.gender, equals(UserGender.male));
    });

    test('toJson should produce a valid JSON map', () {
      final user = const User(
        id: '456',
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        gender: UserGender.female,
      );

      final json = user.toJson();

      expect(json['id'], equals('456'));
      expect(json['firstName'], equals('Jane'));
      expect(json['lastName'], equals('Doe'));
      expect(json['email'], equals('jane@example.com'));
      expect(json['gender'], equals('Female'));
    });

    test(
      'round-trip conversion (toJson and fromJson) should preserve data',
      () {
        final original = const User(
          id: '789',
          firstName: 'Alice',
          lastName: 'Smith',
          email: 'alice@example.com',
          gender: UserGender.female,
        );

        final json = original.toJson();
        final user = User.fromJson(json);

        expect(user.id, equals(original.id));
        expect(user.firstName, equals(original.firstName));
        expect(user.lastName, equals(original.lastName));
        expect(user.email, equals(original.email));
        expect(user.gender, equals(original.gender));
      },
    );

    test('fromJson should set gender to null for unknown enum values', () {
      final jsonMap = <String, dynamic>{
        'id': '321',
        'firstName': 'Bob',
        'lastName': 'Marley',
        'email': 'bob@example.com',
        'gender': 'nonexistent',
      };

      final user = User.fromJson(jsonMap);

      expect(user.gender, isNull);
    });
  });
}
