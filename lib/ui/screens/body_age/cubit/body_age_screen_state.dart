import 'package:app_template/data/models/health_metrics.dart'; // Import เพิ่ม
import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum BodyAgeStatus {
  initial,
  loading,
  success,
  failure
  ;

  bool get isLoading => this == BodyAgeStatus.loading;
  bool get isSuccess => this == BodyAgeStatus.success;
  bool get isFailure => this == BodyAgeStatus.failure;
}

final class BodyAgeState extends Equatable {
  final BodyAgeStatus status;
  final int? bodyAge;
  final HealthMetrics? metrics;
  final AppError? error;

  const BodyAgeState({
    this.status = BodyAgeStatus.initial,
    this.bodyAge,
    this.metrics,
    this.error,
  });

  @override
  List<Object?> get props => [status, bodyAge, metrics, error];

  BodyAgeState copyWith({
    BodyAgeStatus? status,
    int? bodyAge,
    HealthMetrics? metrics,
    AppError? error,
  }) {
    return BodyAgeState(
      status: status ?? this.status,
      bodyAge: bodyAge ?? this.bodyAge,
      metrics: metrics ?? this.metrics,
      error: error ?? this.error,
    );
  }

  BodyAgeState loading() =>
      copyWith(status: BodyAgeStatus.loading, error: null);

  BodyAgeState success({required int age, required HealthMetrics metrics}) =>
      copyWith(
        status: BodyAgeStatus.success,
        bodyAge: age,
        metrics: metrics,
        error: null,
      );
  BodyAgeState failure(AppError error) =>
      copyWith(status: BodyAgeStatus.failure, error: error);
}
