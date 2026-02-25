import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/user_repository.dart';
import 'package:jenosize/domain/storages/token_vault.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';

class SplashScreenUseCase {
  final TokenVault tokenVault;
  final UserRepository userRepository;
  final SessionCubit sessionCubit;

  SplashScreenUseCase({
    required this.tokenVault,
    required this.userRepository,
    required this.sessionCubit,
  });

  Future<Result<User>> getUserSession() async {
    final hasAccessToken = await tokenVault.hasAccessToken();
    if (!hasAccessToken) {
      return const Failure(AppError(message: 'Access token not found'));
    }

    if (sessionCubit.state.user != null) {
      return Success(sessionCubit.state.user!);
    }

    final result = await userRepository.getProfile();
    switch (result) {
      case Success(:final value):
        sessionCubit.setUser(value);
        return Success(value);
      case Failure(:final error):
        return Failure(error);
    }
  }
}
