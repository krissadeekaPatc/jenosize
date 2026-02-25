import 'package:app_template/data/models/fcm_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FcmPayload', () {
    test('fromJson should correctly parse valid JSON', () {
      final Map<String, dynamic> json = {'title': 'Hello', 'body': 'World'};

      final fcmPayload = FcmPayload.fromJson(json);

      expect(fcmPayload.title, equals('Hello'));
      expect(fcmPayload.body, equals('World'));
    });

    test('toJson should return a valid JSON map', () {
      final fcmPayload = const FcmPayload(title: 'Hello', body: 'World');

      final json = fcmPayload.toJson();

      expect(json['title'], equals('Hello'));
      expect(json['body'], equals('World'));
    });

    test(
      'round-trip conversion (toJson and fromJson) should preserve data',
      () {
        final original = const FcmPayload(title: 'Hello', body: 'World');

        final json = original.toJson();
        final fcmPayload = FcmPayload.fromJson(json);

        expect(fcmPayload.title, equals(original.title));
        expect(fcmPayload.body, equals(original.body));
      },
    );

    test('fromJsonOrNull should return null when provided null input', () {
      final fcmPayload = FcmPayload.fromJsonOrNull(null);

      expect(fcmPayload, isNull);
    });

    test('fromJsonOrNull should return null for invalid JSON', () {
      final invalidJson = <String, dynamic>{'title': 123, 'body': 'World'};

      final fcmPayload = FcmPayload.fromJsonOrNull(invalidJson);

      expect(fcmPayload, isNull);
    });
  });
}
