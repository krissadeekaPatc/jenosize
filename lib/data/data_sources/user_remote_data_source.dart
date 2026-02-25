import 'package:app_template/data/models/user.dart';
import 'package:app_template/domain/api_client/api_client.dart';

class UserRemoteDataSource {
  final ApiClient _apiClient;

  const UserRemoteDataSource(this._apiClient);

  Future<User> me() async {
    const path = '/api/user/me';
    final response = await _apiClient.get(path);
    return User.fromJson(response.data['data']);
  }
}
