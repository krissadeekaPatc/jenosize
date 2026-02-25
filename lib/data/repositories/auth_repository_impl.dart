import 'package:app_template/data/data_sources/auth_remote_data_source.dart';
import 'package:app_template/data/models/auth.dart';
import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Auth>> loginWithEmail({
    required LoginWithEmailRequest request,
  }) async {
    try {
      final result = await _remoteDataSource.loginWithEmail(
        request: request,
      );
      return Success(result);
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }
}
