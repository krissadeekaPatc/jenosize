import 'package:equatable/equatable.dart';

enum MembershipScreenStatus {
  initial,
  loading,
  ready,
  failure,
  ;

  bool get isLoading => this == MembershipScreenStatus.loading;
}

class MembershipScreenState extends Equatable {
  final MembershipScreenStatus status;
  final Exception? error;

  const MembershipScreenState({
    this.status = MembershipScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    error,
  ];

  MembershipScreenState copyWith({
    MembershipScreenStatus? status,
    Exception? error,
  }) {
    return MembershipScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  MembershipScreenState loading() {
    return copyWith(
      status: MembershipScreenStatus.loading,
    );
  }

  MembershipScreenState ready() {
    return copyWith(
      status: MembershipScreenStatus.ready,
    );
  }

  MembershipScreenState failure(
    Exception error,
  ) {
    return copyWith(
      status: MembershipScreenStatus.failure,
      error: error,
    );
  }
}
