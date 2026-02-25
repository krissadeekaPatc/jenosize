import 'package:equatable/equatable.dart';
import 'package:jenosize/domain/core/app_error.dart';

enum SettingsScreenStatus {
  initial,
  loading,
  ready,
  failure,
  success
  ;

  bool get isLoading => this == SettingsScreenStatus.loading;
}

class SettingsScreenState extends Equatable {
  final SettingsScreenStatus status;
  final String appName;
  final String version;
  final AppError? error;

  const SettingsScreenState({
    this.status = SettingsScreenStatus.initial,
    this.appName = '',
    this.version = '',
    this.error,
  });

  @override
  List<Object?> get props => [status, appName, version, error];

  SettingsScreenState copyWith({
    SettingsScreenStatus? status,
    String? appName,
    String? version,
    AppError? error,
  }) {
    return SettingsScreenState(
      status: status ?? this.status,
      appName: appName ?? this.appName,
      version: version ?? this.version,
      error: error ?? this.error,
    );
  }

  SettingsScreenState loading() {
    return copyWith(status: SettingsScreenStatus.loading);
  }

  SettingsScreenState ready() {
    return copyWith(status: SettingsScreenStatus.ready);
  }

  SettingsScreenState success() {
    return copyWith(status: SettingsScreenStatus.success);
  }

  SettingsScreenState failure(AppError error) {
    return copyWith(status: SettingsScreenStatus.failure, error: error);
  }
}
