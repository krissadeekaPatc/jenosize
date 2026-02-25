import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/health_repository.dart';
import 'package:app_template/domain/use_cases/calculate_body_age_use_case.dart';

class SyncAndCalculateBodyAgeUseCase {
  final HealthRepository _healthRepository;
  final CalculateBodyAgeUseCase _calculateBodyAgeUseCase;

  const SyncAndCalculateBodyAgeUseCase({
    required HealthRepository healthRepository,
    required CalculateBodyAgeUseCase calculateBodyAgeUseCase,
  }) : _healthRepository = healthRepository,
       _calculateBodyAgeUseCase = calculateBodyAgeUseCase;

  Future<Result<int>> call({required int chronologicalAge}) async {
    final healthDataResult = await _healthRepository.getAggregatedHealthData();

    switch (healthDataResult) {
      case Success(value: final request):
        return _calculateBodyAgeUseCase.call(
          chronologicalAge: chronologicalAge,
          isMale: true,
          metrics: request,
        );

      case Failure(:final error):
        return Failure(error);
    }
  }
}
