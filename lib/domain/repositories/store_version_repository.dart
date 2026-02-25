import 'package:jenosize/data/models/version_status.dart';

abstract class StoreVersionRepository {
  Future<VersionStatus?> getVersionStatus();
}
