import 'package:jenosize/data/data_sources/store_version_remote_data_source.dart';
import 'package:jenosize/data/models/version_status.dart';
import 'package:jenosize/domain/repositories/store_version_repository.dart';

class StoreVersionRepositoryImpl implements StoreVersionRepository {
  final StoreVersionRemoteDataSource _remote;

  const StoreVersionRepositoryImpl(this._remote);

  @override
  Future<VersionStatus?> getVersionStatus() {
    return _remote.getVersionStatus();
  }
}
