import 'package:app_template/data/models/auth.dart';
import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/auth_repository.dart';
import 'package:app_template/domain/storages/token_vault.dart';
import 'package:app_template/domain/use_cases/get_user_use_case.dart';

class LoginWithEmailUseCase {
  final AuthRepository _authRepository;
  final GetUserUseCase _getUserUseCase;
  final TokenVault _tokenVault;

  const LoginWithEmailUseCase(
    this._authRepository,
    this._getUserUseCase,
    this._tokenVault,
  );

  Future<Result<Auth>> call({required LoginWithEmailRequest request}) async {
    final loginResult = await _authRepository.loginWithEmail(request: request);

    switch (loginResult) {
      case Success(value: final auth):
        await _tokenVault.setAuth(auth);

        final userResult = await _getUserUseCase.call();
        if (userResult is Failure) {
          return Failure((userResult as Failure).error);
        }
        return Success(auth);

      case Failure(:final error):
        return Failure(error);
    }
  }
}
