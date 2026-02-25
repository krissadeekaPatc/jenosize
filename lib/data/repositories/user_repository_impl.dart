import 'package:app_template/data/data_sources/user_remote_data_source.dart';
import 'package:app_template/data/models/user.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  const UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<User>> getProfile() async {
    try {
      final result = await _remoteDataSource.getProfile();
      return Success(result);
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }
}
