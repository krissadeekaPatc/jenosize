import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/use_cases/login_with_email_use_case.dart';
import 'package:app_template/ui/screens/login/cubit/login_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final LoginWithEmailUseCase loginWithEmailUseCase;

  LoginScreenCubit({required this.loginWithEmailUseCase})
    : super(const LoginScreenState());

  void skipLogin() async {
    emit(state.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.success());
  }

  void login() async {
    emit(state.loading());

    final result = await loginWithEmailUseCase.call(
      request: const LoginWithEmailRequest(
        email: '',
        password: '',
      ),
    );

    switch (result) {
      case Success():
        emit(state.success());
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
