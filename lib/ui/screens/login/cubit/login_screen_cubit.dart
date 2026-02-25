import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/use_cases/login_with_email_use_case.dart';
import 'package:app_template/ui/screens/login/cubit/login_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final LoginWithEmailUseCase _loginUseCase;

  LoginScreenCubit(this._loginUseCase) : super(const LoginScreenState());

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;

    emit(state.loading());

    final request = LoginWithEmailRequest(email: email, password: password);
    final result = await _loginUseCase.call(request: request);

    switch (result) {
      case Success():
        emit(state.success());
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
