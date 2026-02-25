import 'package:equatable/equatable.dart';

class VersionStatus extends Equatable {
  final String localVersion;
  final String storeVersion;
  final String appStoreLink;

  const VersionStatus({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
  });

  @override
  List<Object?> get props => [
    localVersion,
    storeVersion,
    appStoreLink,
  ];

  /// Returns `true` if the store version of the application is greater than the local version.
  bool get canUpdate {
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();

    // Each consecutive field in the version notation is less significant than the previous one,
    // therefore only one comparison needs to yield `true` for it to be determined that the store
    // version is greater than the local version.
    for (var i = 0; i < store.length; i++) {
      // The store version field is newer than the local version.
      if (store[i] > local[i]) {
        return true;
      }

      // The local version field is newer than the store version.
      if (local[i] > store[i]) {
        return false;
      }
    }

    // The local and store versions are the same.
    return false;
  }
}
