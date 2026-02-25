import 'package:jenosize/data/data_sources/point_remote_data_source.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/point_repository.dart';

class PointRepositoryImpl implements PointRepository {
  final PointRemoteDataSource _remoteDataSource;

  const PointRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<PointHistory>>> getPointTransactions({
    required String userId,
  }) async {
    try {
      final result = await _remoteDataSource.getPointTransactions(
        userId: userId,
      );
      return Success(result);
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }

  @override
  Future<Result<Unit>> addTransaction({
    required String userId,
    required String title,
    required int points,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      return Success(Unit());
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }
}
