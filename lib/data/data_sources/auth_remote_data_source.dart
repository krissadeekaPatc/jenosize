import 'package:app_template/data/models/auth.dart';
import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/api_client/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient;

  const AuthRemoteDataSource(this._apiClient);

  Future<Auth> loginWithEmail({required LoginWithEmailRequest request}) async {
    const path = '/api/app/auth/credentials/signin';
    final response = await _apiClient.post(
      path,
      data: request.toJson(),
    );
    return Auth.fromJson(response.data['data']);
  }
}
