import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/generated/assets.gen.dart';

class PointRemoteDataSource {
  final AssetBundle bundle;

  PointRemoteDataSource({required this.bundle});

  Future<List<PointHistory>> getPointTransactions({
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final String response = await bundle.loadString(
      Assets.mocks.pointHistory,
    );

    final List<dynamic> data = json.decode(response);

    return data
        .map((e) => PointHistory.fromJson(e))
        .where((txn) => txn.userId == userId)
        .toList();
  }
}
