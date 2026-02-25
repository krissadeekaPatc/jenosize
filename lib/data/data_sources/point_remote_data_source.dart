import 'package:app_template/data/models/point_history.dart';

class PointRemoteDataSource {
  const PointRemoteDataSource();

  Future<List<PointHistory>> getPointTransactions({
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final now = DateTime.now();

    return [
      PointHistory(
        id: 'txn_001',
        userId: userId,
        title: 'Joined: Summer Coffee Fiesta',
        points: 50,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      PointHistory(
        id: 'txn_002',
        userId: userId,
        title: 'Refer a Friend Bonus',
        points: 100,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      PointHistory(
        id: 'txn_003',
        userId: userId,
        title: 'Welcome Bonus',
        points: 200,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ];
  }
}
