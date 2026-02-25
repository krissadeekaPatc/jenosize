import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/auth_repository.dart';
import 'package:app_template/domain/use_cases/get_user_use_case.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';

class LoginWithEmailUseCase {
  final SessionCubit sessionCubit;
  final AuthRepository authRepository;
  final GetUserUseCase getUserUseCase;

  LoginWithEmailUseCase({
    required this.sessionCubit,
    required this.authRepository,
    required this.getUserUseCase,
  });

  Future<Result<Unit>> call({required LoginWithEmailRequest request}) async {
    final result = await authRepository.loginWithEmail(request: request);

    switch (result) {
      case Success():
        return getUserUseCase.me();
      case Failure():
        return Failure(result.error);
    }
  }
}
