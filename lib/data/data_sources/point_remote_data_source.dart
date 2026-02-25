import 'package:jenosize/data/models/point_history.dart';

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
        title: 'Redeemed: ฿50 Discount Coupon',
        points: -500,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      PointHistory(
        id: 'txn_002',
        userId: userId,
        title: 'Joined: Summer Coffee Fiesta',
        points: 50,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
      PointHistory(
        id: 'txn_003',
        userId: userId,
        title: 'Birthday Month Surprise',
        points: 300,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      PointHistory(
        id: 'txn_004',
        userId: userId,
        title: 'Refer a Friend Bonus',
        points: 100,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      PointHistory(
        id: 'txn_005',
        userId: userId,
        title: 'Redeemed: Free Iced Latte',
        points: -150,
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      PointHistory(
        id: 'txn_006',
        userId: userId,
        title: 'Welcome Bonus',
        points: 700,
        createdAt: now.subtract(const Duration(days: 15)),
      ),
    ];
  }
}
