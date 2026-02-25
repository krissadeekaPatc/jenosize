import 'package:app_template/data/models/user.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/user_repository.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';

class GetUserUseCase {
  final SessionCubit _sessionCubit;
  final UserRepository _userRepository;

  const GetUserUseCase(
    this._sessionCubit,
    this._userRepository,
  );

  Future<Result<User>> call() async {
    final result = await _userRepository.getProfile();

    switch (result) {
      case Success(value: final user):
        _sessionCubit.setUser(user);
        return Success(user);
      case Failure(:final error):
        return Failure(error);
    }
  }
}
