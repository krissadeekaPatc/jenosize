import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginWithEmailRequest', () {
    test('fromJson should correctly parse valid JSON', () {
      final Map<String, dynamic> json = {
        'email': 'test@example.com',
        'password': 'password',
      };

      final request = LoginWithEmailRequest.fromJson(json);

      expect(request.email, equals('test@example.com'));
      expect(request.password, equals('password'));
    });

    test('toJson should return a valid JSON map', () {
      final request = const LoginWithEmailRequest(
        email: 'test@example.com',
        password: 'password',
      );

      final jsonMap = request.toJson();

      expect(jsonMap['email'], equals('test@example.com'));
      expect(jsonMap['password'], equals('password'));
    });

    test(
      'round-trip conversion (toJson and fromJson) should preserve data',
      () {
        final request = const LoginWithEmailRequest(
          email: 'test@example.com',
          password: 'password',
        );

        final jsonMap = request.toJson();
        final fromJson = LoginWithEmailRequest.fromJson(jsonMap);

        expect(fromJson.email, equals(request.email));
        expect(fromJson.password, equals(request.password));
      },
    );
  });
}
