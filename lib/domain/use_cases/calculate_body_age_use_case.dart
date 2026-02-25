import 'package:app_template/data/models/health_metrics.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';

class CalculateBodyAgeUseCase {
  const CalculateBodyAgeUseCase();

  Result<int> call({
    required int chronologicalAge,
    required bool isMale,
    required HealthMetrics metrics,
  }) {
    if (chronologicalAge <= 0) {
      return const Failure(AppError(message: 'Invalid chronological age.'));
    }

    double bodyAge = chronologicalAge.toDouble();

    // ---------------------------------------------------------
    // แกนที่ 1: Body Composition (น้ำหนัก/ไขมัน) - มีผลสูงสุด
    // ---------------------------------------------------------
    if (metrics.bodyFatPercentage != null) {
      // ใช้ Body Fat เป็นหลัก (ชายอุดมคติ ~15-20%, หญิง ~20-25%)
      double idealFat = isMale ? 18.0 : 23.0;
      double fatDiff = metrics.bodyFatPercentage! - idealFat;
      // ไขมันเกิน 1% อายุเพิ่ม 0.3 ปี
      bodyAge += (fatDiff * 0.3);
    } else if (metrics.weight != null && metrics.height != null) {
      // ถ้าไม่มีไขมัน ให้ใช้ BMI แทน
      double hInMeters = metrics.height! > 3.0
          ? metrics.height! / 100
          : metrics.height!;
      double bmi = metrics.weight! / (hInMeters * hInMeters);
      bodyAge += ((bmi - 22.0) * 0.4);
    }

    // ---------------------------------------------------------
    // แกนที่ 2: Cardiovascular Health (สุขภาพหัวใจ)
    // ---------------------------------------------------------
    if (metrics.restingHeartRate != null) {
      // หัวใจเต้นช้า = ฟิตมาก (อุดมคติ 60-70)
      if (metrics.restingHeartRate! > 75) {
        bodyAge += (metrics.restingHeartRate! - 75) * 0.15;
      } else if (metrics.restingHeartRate! < 65) {
        bodyAge -= (65 - metrics.restingHeartRate!) * 0.2;
      }
    }

    if (metrics.hrv != null) {
      if (metrics.hrv! >= 60) {
        bodyAge -= 2.0;
      } else if (metrics.hrv! >= 45) {
        bodyAge -= 1.0;
      } else if (metrics.hrv! < 30) {
        bodyAge += 1.5;
      }
    }

    // ---------------------------------------------------------
    // แกนที่ 3: Activity Level (การขยับตัว)
    // ---------------------------------------------------------
    if (metrics.dailySteps != null) {
      // เป้าหมายคือเดิน 8,000 ก้าวต่อวัน
      if (metrics.dailySteps! >= 10000) {
        bodyAge -= 2.0;
      } else if (metrics.dailySteps! >= 7500) {
        bodyAge -= 1.0;
      } else if (metrics.dailySteps! < 4000) {
        bodyAge += 1.5;
      }
    }

    if (metrics.dailyActiveEnergy != null) {
      // เป้าหมายเผาผลาญแอคทีฟ ~400-500 kcal/วัน
      if (metrics.dailyActiveEnergy! >= 500) {
        bodyAge -= 1.0;
      } else if (metrics.dailyActiveEnergy! < 200) {
        bodyAge += 1.0;
      }
    }

    // ---------------------------------------------------------
    // แกนที่ 4: Recovery (การนอนหลับ)
    // ---------------------------------------------------------
    if (metrics.dailySleepMinutes != null) {
      // เป้าหมายนอน 7-8 ชั่วโมง (420-480 นาที)
      if (metrics.dailySleepMinutes! >= 420 &&
          metrics.dailySleepMinutes! <= 540) {
        bodyAge -= 1.0; // นอนพอดี
      } else if (metrics.dailySleepMinutes! < 360) {
        bodyAge += 1.5; // นอนน้อยกว่า 6 ชม. ร่างกายแก่เร็ว
      }
    }

    // ---------------------------------------------------------
    // ควบคุมไม่ให้ตัวเลขเหวี่ยงเกินจริง (± 15 ปีจากอายุจริง)
    // ---------------------------------------------------------
    double minAge = chronologicalAge - 15.0;
    double maxAge = chronologicalAge + 15.0;

    bodyAge = bodyAge.clamp(minAge, maxAge);

    return Success(bodyAge < 10 ? 10 : bodyAge.round());
  }
}
