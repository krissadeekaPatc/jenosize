import 'package:app_template/data/models/version_status.dart';

abstract class StoreVersionRepository {
  Future<VersionStatus?> getVersionStatus();
}
