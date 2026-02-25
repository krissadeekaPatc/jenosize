import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/use_cases/sync_and_calculate_body_age_use_case.dart';
import 'package:app_template/ui/screens/body_age/cubit/body_age_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAgeCubit extends Cubit<BodyAgeState> {
  final SyncAndCalculateBodyAgeUseCase _syncUseCase;

  BodyAgeCubit(this._syncUseCase) : super(const BodyAgeState());

  Future<void> syncAndCalculate({required int chronologicalAge}) async {
    emit(state.loading());
    final result = await _syncUseCase.call(chronologicalAge: chronologicalAge);

    switch (result) {
      case Success(value: final age):
        emit(state.success(age));
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
