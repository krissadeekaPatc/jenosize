import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/point_repository.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/screens/point_track/cubit/point_track_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointTrackScreenCubit extends Cubit<PointTrackScreenState> {
  final PointRepository pointRepository;
  final SessionCubit sessionCubit;

  PointTrackScreenCubit({
    required this.pointRepository,
    required this.sessionCubit,
  }) : super(const PointTrackScreenState());

  Future<void> loadTransactions() async {
    final user = sessionCubit.state.user;
    if (user == null || user.id == null) {
      return;
    }

    emit(state.loading());
    final result = await pointRepository.getPointTransactions(
      userId: user.id!,
    );

    switch (result) {
      case Success(value: final transactions):
        emit(state.ready(pointHistories: transactions));
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
