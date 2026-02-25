import 'package:app_template/data/models/health_metrics.dart';
import 'package:app_template/domain/core/result.dart';

abstract class HealthRepository {
  Future<Result<HealthMetrics>> getAggregatedHealthData();
}
