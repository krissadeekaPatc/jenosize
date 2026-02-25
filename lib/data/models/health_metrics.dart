import 'package:equatable/equatable.dart';

class HealthMetrics extends Equatable {
  final double? weight;
  final double? height;
  final double? bodyFatPercentage;
  final double? leanBodyMass;
  final int? restingHeartRate;
  final double? hrv;
  final int? dailySteps;
  final int? dailySleepMinutes;
  final int? dailyActiveEnergy;
  final double? sleepWristTemperature;

  const HealthMetrics({
    this.weight,
    this.height,
    this.bodyFatPercentage,
    this.leanBodyMass,
    this.restingHeartRate,
    this.hrv,
    this.dailySteps,
    this.dailySleepMinutes,
    this.dailyActiveEnergy,
    this.sleepWristTemperature,
  });

  @override
  List<Object?> get props => [
    weight,
    height,
    bodyFatPercentage,
    leanBodyMass,
    restingHeartRate,
    hrv,
    dailySteps,
    dailySleepMinutes,
    dailyActiveEnergy,
    sleepWristTemperature,
  ];
}
