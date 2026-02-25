import 'package:equatable/equatable.dart';

enum SplashScreenStatus {
  initial,
  authenticated,
  unauthenticated,
}

class SplashScreenState extends Equatable {
  final SplashScreenStatus status;

  const SplashScreenState({
    this.status = SplashScreenStatus.initial,
  });

  @override
  List<Object?> get props => [
    status,
  ];

  SplashScreenState copyWith({
    SplashScreenStatus? status,
  }) {
    return SplashScreenState(
      status: status ?? this.status,
    );
  }

  SplashScreenState authenticated() {
    return copyWith(
      status: SplashScreenStatus.authenticated,
    );
  }

  SplashScreenState unauthenticated() {
    return copyWith(
      status: SplashScreenStatus.unauthenticated,
    );
  }
}
