import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/use_cases/splash_use_case.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final SessionCubit sessionCubit;
  final SplashScreenUseCase useCase;

  SplashScreenCubit({
    required this.sessionCubit,
    required this.useCase,
  }) : super(const SplashScreenState());

  void initialize() async {
    final result = await useCase.getUserSession();
    switch (result) {
      case Success():
        emit(state.authenticated());

      case Failure():
        emit(state.unauthenticated());
    }
  }
}
