import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<Auth> loginWithEmail({required LoginWithEmailRequest request}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return Auth(
      accessToken: 'mock_access_token_jenosize_123',
      refreshToken: 'mock_refresh_token_jenosize_123',
      expiredAt: DateTime.now().add(const Duration(days: 1)),
    );
  }
}
