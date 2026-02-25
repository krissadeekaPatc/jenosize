import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum SettingsScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == SettingsScreenStatus.loading;
}

class SettingsScreenState extends Equatable {
  final SettingsScreenStatus status;
  final AppError? error;

  const SettingsScreenState({
    this.status = SettingsScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [status, error];

  SettingsScreenState copyWith({
    SettingsScreenStatus? status,
    AppError? error,
  }) {
    return SettingsScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  SettingsScreenState loading() {
    return copyWith(status: SettingsScreenStatus.loading);
  }

  SettingsScreenState ready() {
    return copyWith(status: SettingsScreenStatus.ready);
  }

  SettingsScreenState failure(AppError error) {
    return copyWith(status: SettingsScreenStatus.failure, error: error);
  }
}
