import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/use_cases/splash_use_case.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:app_template/ui/screens/splash/cubit/splash_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final SessionCubit sessionCubit;
  final SplashScreenUseCase useCase;

  SplashScreenCubit({
    required this.sessionCubit,
    required this.useCase,
  }) : super(const SplashScreenState());

  void initialize() async {
    final status = await useCase.getVersionStatus();
    final canUpdate = status?.canUpdate ?? false;
    final storeVersion = status?.storeVersion;
    final appStoreLink = status?.appStoreLink;
    if (canUpdate && appStoreLink != null) {
      emit(
        state.newVersionAvailable(
          appStoreLink: appStoreLink,
          storeVersion: storeVersion,
        ),
      );
    } else {
      final result = await useCase.getUserSession();
      switch (result) {
        case Success(:final value):
          sessionCubit.setUser(value);
          emit(state.authenticated());

        case Failure():
          emit(state.unauthenticated());
      }
    }
  }
}
