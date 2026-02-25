import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/user_repository.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';

class GetUserUseCase {
  final SessionCubit _sessionCubit;
  final UserRepository _userRepository;

  const GetUserUseCase(
    this._sessionCubit,
    this._userRepository,
  );

  Future<Result<User>> call() async {
    final currentUser = _sessionCubit.state.user;
    if (currentUser != null) {
      return Success(currentUser);
    }

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
