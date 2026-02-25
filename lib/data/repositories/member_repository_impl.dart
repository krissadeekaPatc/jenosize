import 'dart:convert';

import 'package:app_template/data/models/point_transaction.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/member_repository.dart';
import 'package:app_template/domain/storages/app_storage.dart';

class MemberRepositoryImpl implements MemberRepository {
  final AppStorage _appStorage;

  static const String _membershipKey = 'loyalty_is_member';
  static const String _pointsKey = 'loyalty_total_points';
  static const String _transactionsKey = 'loyalty_transactions';

  const MemberRepositoryImpl(this._appStorage);

  @override
  Future<Result<bool>> getMembershipStatus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final isMember = await _appStorage.getBool(_membershipKey) ?? false;
      return Success(isMember);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<void>> joinMembership() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _appStorage.setBool(_membershipKey, true);

      await _savePointsAndTransactionLocally(
        title: 'Welcome Bonus',
        points: 200,
      );
      return const Success(null);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<int>> getTotalPoints() async {
    try {
      final points = await _appStorage.getInt(_pointsKey) ?? 0;
      return Success(points);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<List<PointTransaction>>> getTransactionHistory() async {
    try {
      final jsonString = await _appStorage.getString(_transactionsKey);
      if (jsonString == null) return const Success([]);

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final transactions = jsonList
          .map((json) => PointTransaction.fromJson(json))
          .toList();

      transactions.sort((a, b) => b.date.compareTo(a.date));
      return Success(transactions);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<void>> addPointsAndTransaction({
    required String title,
    required int points,
  }) async {
    try {
      await _savePointsAndTransactionLocally(title: title, points: points);
      return const Success(null);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  Future<void> _savePointsAndTransactionLocally({
    required String title,
    required int points,
  }) async {
    final currentPoints = await _appStorage.getInt(_pointsKey) ?? 0;
    await _appStorage.setInt(_pointsKey, currentPoints + points);

    final jsonString = await _appStorage.getString(_transactionsKey);
    final List<dynamic> currentList = jsonString != null
        ? jsonDecode(jsonString)
        : [];

    final newTransaction = PointTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      points: points,
      date: DateTime.now(),
    );

    currentList.add(newTransaction.toJson());
    await _appStorage.setString(_transactionsKey, jsonEncode(currentList));
  }
}
