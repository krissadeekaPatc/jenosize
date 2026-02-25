import 'package:jenosize/data/models/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auth', () {
    test('fromJson should parse fields correctly', () {
      final Map<String, dynamic> json = {
        'accessToken': 'token123',
        'refreshToken': 'secretXYZ',
        'expiredAt': '2025-01-01T00:00:00.000Z',
      };

      final auth = Auth.fromJson(json);

      expect(auth.accessToken, equals('token123'));
      expect(auth.refreshToken, equals('secretXYZ'));
      expect(
        auth.expiredAt,
        equals(DateTime.parse('2025-01-01T00:00:00.000Z')),
      );
    });

    test('toJson should produce correct JSON map', () {
      final auth = Auth(
        accessToken: 'token123',
        refreshToken: 'secretXYZ',
        expiredAt: DateTime.parse('2025-01-01T00:00:00.000Z'),
      );

      final json = auth.toJson();

      expect(json['accessToken'], equals('token123'));
      expect(json['refreshToken'], equals('secretXYZ'));
      expect(json['expiredAt'], equals('2025-01-01T00:00:00.000Z'));
    });

    test('round-trip conversion preserves data', () {
      final original = Auth(
        accessToken: 'token123',
        refreshToken: 'secretXYZ',
        expiredAt: DateTime.parse('2025-01-01T00:00:00.000Z'),
      );

      final json = original.toJson();
      final auth = Auth.fromJson(json);

      expect(auth.accessToken, equals(original.accessToken));
      expect(auth.refreshToken, equals(original.refreshToken));
      expect(auth.expiredAt, equals(original.expiredAt));
    });
  });
}
