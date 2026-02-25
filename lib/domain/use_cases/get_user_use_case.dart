import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/user_repository.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';

class GetUserUseCase {
  final SessionCubit sessionCubit;
  final UserRepository userRepository;

  const GetUserUseCase({
    required this.sessionCubit,
    required this.userRepository,
  });

  Future<Result<Unit>> me() async {
    final result = await userRepository.me();
    switch (result) {
      case Success():
        sessionCubit.setUser(result.value);
        return Success(Unit());
      case Failure():
        return Failure(result.error);
    }
  }
}
