import 'package:equatable/equatable.dart';

enum SplashScreenStatus {
  initial,
  newVersionAvailable,
  authenticated,
  unauthenticated,
}

class SplashScreenState extends Equatable {
  final SplashScreenStatus status;
  final String? appStoreLink;
  final String? storeVersion;

  const SplashScreenState({
    this.status = SplashScreenStatus.initial,
    this.appStoreLink,
    this.storeVersion,
  });

  @override
  List<Object?> get props => [
    status,
    appStoreLink,
    storeVersion,
  ];

  SplashScreenState copyWith({
    SplashScreenStatus? status,
    String? appStoreLink,
    String? storeVersion,
  }) {
    return SplashScreenState(
      status: status ?? this.status,
      appStoreLink: appStoreLink ?? this.appStoreLink,
      storeVersion: storeVersion ?? this.storeVersion,
    );
  }

  SplashScreenState newVersionAvailable({
    required String appStoreLink,
    required String? storeVersion,
  }) {
    return copyWith(
      status: SplashScreenStatus.newVersionAvailable,
      appStoreLink: appStoreLink,
      storeVersion: storeVersion,
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
