import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/domain/core/result.dart';

abstract class PointRepository {
  Future<Result<List<PointHistory>>> getPointTransactions({
    required String userId,
  });
  Future<Result<void>> addTransaction({
    required String userId,
    required String title,
    required int points,
  });
}
