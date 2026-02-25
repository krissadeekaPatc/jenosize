import 'package:app_template/data/models/point_transaction.dart';
import 'package:app_template/domain/core/result.dart';

abstract class MemberRepository {
  Future<Result<bool>> getMembershipStatus();
  Future<Result<void>> joinMembership();

  Future<Result<int>> getTotalPoints();
  Future<Result<List<PointTransaction>>> getTransactionHistory();

  Future<Result<void>> addPointsAndTransaction({
    required String title,
    required int points,
  });
}
