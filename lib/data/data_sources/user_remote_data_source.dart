import 'package:app_template/data/models/user.dart';

class UserRemoteDataSource {
  const UserRemoteDataSource();

  Future<User> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return const User(
      id: 'usr_mock_001',
      firstName: 'Jeno',
      lastName: 'Tester',
      email: 'admin@jenosize.com',
    );
  }
}
