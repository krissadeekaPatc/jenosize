import 'package:jenosize/data/data_sources/user_remote_data_source.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/user_repository.dart';

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
