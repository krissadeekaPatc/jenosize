import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum HomeScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == HomeScreenStatus.loading;
}

class HomeScreenState extends Equatable {
  final HomeScreenStatus status;
  final AppError? error;

  const HomeScreenState({this.status = HomeScreenStatus.initial, this.error});

  @override
  List<Object?> get props => [status, error];

  HomeScreenState copyWith({HomeScreenStatus? status, AppError? error}) {
    return HomeScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  HomeScreenState loading() {
    return copyWith(status: HomeScreenStatus.loading);
  }

  HomeScreenState ready() {
    return copyWith(status: HomeScreenStatus.ready);
  }

  HomeScreenState failure(AppError error) {
    return copyWith(status: HomeScreenStatus.failure, error: error);
  }
}
