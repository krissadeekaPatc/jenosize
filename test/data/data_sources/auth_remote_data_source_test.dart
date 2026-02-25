import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/data_sources/auth_remote_data_source.dart';
import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';

void main() {
  late AuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = const AuthRemoteDataSource();
  });

  /*
   * AuthRemoteDataSource Test Cases:
   * 1. loginWithEmail Success: ตรวจสอบว่าเมื่อเรียก login ด้วย request ที่ถูกต้อง 
   * จะต้องคืนค่า Auth object ที่มี access token และ refresh token ตามที่กำหนดไว้
   */
  group('AuthRemoteDataSource', () {
    test('loginWithEmail returns valid Auth object after delay', () async {
      const request = LoginWithEmailRequest(
        email: 'test@jenosize.com',
        password: 'password123',
      );

      final result = await dataSource.loginWithEmail(request: request);

      expect(result, isA<Auth>());
      expect(result.accessToken, isNotEmpty);
      expect(result.refreshToken, isNotEmpty);
      expect(result.expiredAt?.isAfter(DateTime.now()), isTrue);
    });
  });
}
