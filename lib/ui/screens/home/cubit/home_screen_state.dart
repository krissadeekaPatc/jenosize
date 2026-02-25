import 'package:app_template/data/models/campaign.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum HomeScreenStatus {
  initial,
  loading,
  ready,
  failure,
  ;

  bool get isLoading => this == HomeScreenStatus.loading;
}

class HomeScreenState extends Equatable {
  final HomeScreenStatus status;
  final AppError? error;
  final List<Campaign?> campaigns;

  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.error,
    this.campaigns = const [],
  });

  @override
  List<Object?> get props => [
    status,
    campaigns,
    error,
  ];

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    List<Campaign?>? campaigns,
    AppError? error,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      error: error ?? this.error,
    );
  }

  HomeScreenState loading() {
    return copyWith(
      status: HomeScreenStatus.loading,
    );
  }

  HomeScreenState ready() {
    return copyWith(
      status: HomeScreenStatus.ready,
    );
  }

  HomeScreenState failure(
    AppError error,
  ) {
    return copyWith(
      status: HomeScreenStatus.failure,
      error: error,
    );
  }
}
