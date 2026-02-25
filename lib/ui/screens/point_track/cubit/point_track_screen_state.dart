import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

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
  final List<PointHistory> pointHistories;
  final AppError? error;

  const PointTrackScreenState({
    this.status = PointTrackScreenStatus.initial,
    this.pointHistories = const [],
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    pointHistories,
    error,
  ];

  PointTrackScreenState copyWith({
    PointTrackScreenStatus? status,
    List<PointHistory>? pointHistories,
    AppError? error,
  }) {
    return PointTrackScreenState(
      status: status ?? this.status,
      pointHistories: pointHistories ?? this.pointHistories,
      error: error ?? this.error,
    );
  }

  PointTrackScreenState loading() {
    return copyWith(
      status: PointTrackScreenStatus.loading,
    );
  }

  PointTrackScreenState ready({
    List<PointHistory>? pointHistories,
  }) {
    return copyWith(
      status: PointTrackScreenStatus.ready,
      pointHistories: pointHistories,
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
