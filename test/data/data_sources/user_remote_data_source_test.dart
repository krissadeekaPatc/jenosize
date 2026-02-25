import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/data_sources/user_remote_data_source.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late UserRemoteDataSource dataSource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = UserRemoteDataSource(bundle: mockAssetBundle);
  });

  /*
   * UserRemoteDataSource Test Cases:
   * 1. getProfile Success: ตรวจสอบว่าเมื่อเรียก getProfile จะต้องคืนค่า User object 
   * ที่มีข้อมูล id, email และชื่อ-นามสกุล ตรงตามที่ Mock ไว้ใน Data Source
   */
  group('UserRemoteDataSource', () {
    test('getProfile returns mock user data after delay', () async {
      const mockJsonString = '''
        {
          "id": "usr_mock_001",
          "totalPoints": 500,
          "firstName": "Jeno",
          "lastName": "Tester",
          "email": "admin@jenosize.com"
        }
      ''';

      when(
        () => mockAssetBundle.loadString(Assets.mocks.user),
      ).thenAnswer((_) async => mockJsonString);

      final result = await dataSource.getProfile();

      expect(result, isA<User>());
      expect(result.id, equals('usr_mock_001'));
      expect(result.totalPoints, equals(500));
      expect(result.firstName, equals('Jeno'));
      expect(result.lastName, equals('Tester'));
      expect(result.email, equals('admin@jenosize.com'));
    });
  });
}
