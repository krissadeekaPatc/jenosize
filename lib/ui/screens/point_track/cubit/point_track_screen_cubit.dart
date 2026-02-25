import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/use_cases/get_point_transaction_usecase.dart';
import 'package:jenosize/ui/screens/point_track/cubit/point_track_screen_state.dart';

class PointTrackScreenCubit extends Cubit<PointTrackScreenState> {
  final GetPointTransactionsUseCase getPointTransactionsUseCase;

  PointTrackScreenCubit({
    required this.getPointTransactionsUseCase,
  }) : super(const PointTrackScreenState());

  Future<void> loadTransactions() async {
    emit(state.loading());
    final result = await getPointTransactionsUseCase.call();

    switch (result) {
      case Success():
        emit(state.ready());
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
