import 'package:equatable/equatable.dart';
import 'package:jenosize/domain/core/app_error.dart';

enum PointTrackScreenStatus {
  initial,
  loading,
  ready,
  failure,
  ;

  bool get isLoading => this == PointTrackScreenStatus.loading;
}

class PointTrackScreenState extends Equatable {
  final PointTrackScreenStatus status;
  final AppError? error;

  const PointTrackScreenState({
    this.status = PointTrackScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    error,
  ];

  PointTrackScreenState copyWith({
    PointTrackScreenStatus? status,
    AppError? error,
  }) {
    return PointTrackScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  PointTrackScreenState loading() {
    return copyWith(
      status: PointTrackScreenStatus.loading,
    );
  }

  PointTrackScreenState ready() {
    return copyWith(
      status: PointTrackScreenStatus.ready,
    );
  }

  PointTrackScreenState failure(
    AppError error,
  ) {
    return copyWith(
      status: PointTrackScreenStatus.failure,
      error: error,
    );
  }
}
