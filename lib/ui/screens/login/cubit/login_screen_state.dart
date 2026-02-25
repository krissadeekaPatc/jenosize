import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum LoginScreenStatus {
  initial,
  loading,
  ready,
  success,
  failure;

  bool get isLoading => this == LoginScreenStatus.loading;
}

class LoginScreenState extends Equatable {
  final LoginScreenStatus status;
  final AppError? error;

  const LoginScreenState({this.status = LoginScreenStatus.initial, this.error});

  @override
  List<Object?> get props => [status, error];

  LoginScreenState copyWith({LoginScreenStatus? status, AppError? error}) {
    return LoginScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  LoginScreenState loading() {
    return copyWith(status: LoginScreenStatus.loading);
  }

  LoginScreenState ready() {
    return copyWith(status: LoginScreenStatus.ready);
  }

  LoginScreenState success() {
    return copyWith(status: LoginScreenStatus.success);
  }

  LoginScreenState failure(AppError error) {
    return copyWith(status: LoginScreenStatus.failure, error: error);
  }
}
