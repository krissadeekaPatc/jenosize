class CalculateBodyAgeRequest {
  final int chronologicalAge;
  final bool isMale; // เพิ่มตัวแปรเพศ
  final double bmi;
  final int restingHeartRate;
  final int activeMinutesPerWeek;

  const CalculateBodyAgeRequest({
    required this.chronologicalAge,
    required this.isMale,
    required this.bmi,
    required this.restingHeartRate,
    required this.activeMinutesPerWeek,
  });
}
