import 'package:app_template/data/data_sources/health_local_data_source.dart';
import 'package:app_template/data/models/health_metrics.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/health_repository.dart';
import 'package:health/health.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource _dataSource;

  const HealthRepositoryImpl(this._dataSource);

  @override
  Future<Result<HealthMetrics>> getAggregatedHealthData() async {
    try {
      final hasPermission = await _dataSource.requestPermissions();
      if (!hasPermission) {
        return const Failure(
          AppError(message: 'Health permissions not granted.'),
        );
      }

      final dataPoints = await _dataSource.getHealthData();

      double? weight;
      double? height;
      double? bodyFat;
      double? leanMass;
      double? hrvTotal = 0;
      double? wristTemp;

      int restingHrTotal = 0;
      int stepsTotal = 0;
      int sleepTotal = 0;
      int activeEnergyTotal = 0;

      int hrCount = 0;
      int hrvCount = 0;

      for (var point in dataPoints) {
        final value = point.value;
        if (value is! NumericHealthValue) continue;

        final numVal = value.numericValue;

        switch (point.type) {
          case HealthDataType.WEIGHT:
            weight = numVal.toDouble();
          case HealthDataType.HEIGHT:
            height = numVal.toDouble();
          case HealthDataType.BODY_FAT_PERCENTAGE:
            bodyFat = numVal.toDouble() < 1.0
                ? numVal.toDouble() * 100
                : numVal.toDouble();
          case HealthDataType.LEAN_BODY_MASS:
            leanMass = numVal.toDouble();
          case HealthDataType.RESTING_HEART_RATE:
            restingHrTotal += numVal.toInt();
            hrCount++;
          case HealthDataType.HEART_RATE_VARIABILITY_SDNN:
            hrvTotal = (hrvTotal ?? 0) + numVal.toDouble();
            hrvCount++;
          case HealthDataType.STEPS:
            stepsTotal += numVal.toInt();
          case HealthDataType.SLEEP_ASLEEP:
            sleepTotal += numVal.toInt();
          case HealthDataType.ACTIVE_ENERGY_BURNED:
            activeEnergyTotal += numVal.toInt();
          case HealthDataType.SLEEP_WRIST_TEMPERATURE:
            wristTemp = numVal.toDouble();
          default:
            break;
        }
      }

      final avgHr = hrCount > 0 ? (restingHrTotal / hrCount).round() : null;
      final avgHrv = hrvCount > 0 ? (hrvTotal! / hrvCount) : null;

      final avgSteps = stepsTotal > 0 ? (stepsTotal / 7).round() : null;
      final avgSleep = sleepTotal > 0 ? (sleepTotal / 7).round() : null;
      final avgEnergy = activeEnergyTotal > 0
          ? (activeEnergyTotal / 7).round()
          : null;

      final metrics = HealthMetrics(
        weight: weight,
        height: height,
        bodyFatPercentage: bodyFat,
        leanBodyMass: leanMass,
        restingHeartRate: avgHr,
        hrv: avgHrv,
        dailySteps: avgSteps,
        dailySleepMinutes: avgSleep,
        dailyActiveEnergy: avgEnergy,
        sleepWristTemperature: wristTemp,
      );

      return Success(metrics);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }
}
