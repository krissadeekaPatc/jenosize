import 'dart:io';

import 'package:health/health.dart';

class HealthLocalDataSource {
  final Health _health = Health();

  List<HealthDataType> get _healthDataTypes {
    final types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.LEAN_BODY_MASS,
      HealthDataType.RESTING_HEART_RATE,
      HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      HealthDataType.STEPS,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.SLEEP_WRIST_TEMPERATURE,
    ];

    if (Platform.isIOS) {
      types.add(HealthDataType.APPLE_MOVE_TIME);
    } else if (Platform.isAndroid) {
      types.add(HealthDataType.EXERCISE_TIME);
    }

    return types;
  }

  Future<bool> requestPermissions() async {
    final types = _healthDataTypes;

    bool hasPermissions = await _health.hasPermissions(types) ?? false;
    if (!hasPermissions) {
      hasPermissions = await _health.requestAuthorization(types);
    }
    return hasPermissions;
  }

  Future<List<HealthDataPoint>> getHealthData() async {
    final types = _healthDataTypes;
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 7)); // ย้อนหลัง 7 วัน

    try {
      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        startTime: yesterday,
        endTime: now,
        types: types,
      );

      return _health.removeDuplicates(healthData);
    } catch (e) {
      throw Exception('Failed to fetch health data: $e');
    }
  }
}
