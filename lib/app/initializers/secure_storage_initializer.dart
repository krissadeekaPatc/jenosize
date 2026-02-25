import 'package:app_template/data/storages/secure_storage_impl.dart';
import 'package:app_template/domain/storages/app_storage.dart';
import 'package:app_template/domain/storages/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<SecureStorage> initializeSecureStorage(AppStorage storage) async {
  final fss = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device,
    ),
  );

  final secureStorage = SecureStorageImpl(fss);

  final firstLaunchEpoch = await storage.getInt(
    StorageKey.firstOpenEpoch.name,
  );
  if (firstLaunchEpoch == null) {
    await secureStorage.deleteAll();

    final now = DateTime.now();
    await storage.setInt(
      StorageKey.firstOpenEpoch.name,
      now.millisecondsSinceEpoch,
    );
  }

  return secureStorage;
}
