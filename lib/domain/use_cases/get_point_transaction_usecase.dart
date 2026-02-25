import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/point_repository.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';

class GetPointTransactionsUseCase {
  final PointRepository pointRepository;
  final SessionCubit sessionCubit;

  GetPointTransactionsUseCase({
    required this.pointRepository,
    required this.sessionCubit,
  });

  Future<Result<Unit>> call() async {
    final user = sessionCubit.state.user;
    if (user?.id == null) return Success(Unit());

    final histories = sessionCubit.state.pointHistories;
    if (histories.isNotEmpty) return Success(Unit());

    final result = await pointRepository.getPointTransactions(
      userId: user!.id!,
    );

    switch (result) {
      case Success(value: final transactions):
        sessionCubit.setPointHistories(transactions);
        return Success(Unit());
      case Failure(:final error):
        return Failure(error);
    }
  }
}
