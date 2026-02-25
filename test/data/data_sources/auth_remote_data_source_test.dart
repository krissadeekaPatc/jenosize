import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/data_sources/auth_remote_data_source.dart';
import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';
import 'package:jenosize/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockAssetBundle mockAssetBundle;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = AuthRemoteDataSource(bundle: mockAssetBundle);
  });

  /*
   * AuthRemoteDataSource Test Cases:
   * 1. loginWithEmail Success: ตรวจสอบว่าเมื่อเรียก login ด้วย request ที่ถูกต้อง 
   * จะต้องคืนค่า Auth object ที่มี access token และ refresh token ตามที่กำหนดไว้
   */
  group('AuthRemoteDataSource', () {
    test('loginWithEmail returns valid Auth object from JSON mock', () async {
      const request = LoginWithEmailRequest(
        email: 'test@jenosize.com',
        password: 'password123',
      );

      const mockJsonString = '''
      {
        "accessToken": "mock_access_token_jenosize_123",
        "refreshToken": "mock_refresh_token_jenosize_123",
        "expiredAt": "2026-12-31T23:59:59Z"
      }
      ''';

      when(
        () => mockAssetBundle.loadString(Assets.mocks.auth),
      ).thenAnswer((_) async => mockJsonString);

      final result = await dataSource.loginWithEmail(request: request);

      expect(result, isA<Auth>());
      expect(result.accessToken, 'mock_access_token_jenosize_123');
      expect(result.refreshToken, 'mock_refresh_token_jenosize_123');
      expect(result.expiredAt?.isAfter(DateTime.now()), isTrue);

      verify(() => mockAssetBundle.loadString(Assets.mocks.auth)).called(1);
    });
  });
}
