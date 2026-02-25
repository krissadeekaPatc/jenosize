import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.cautionary,
    required this.negative,
    required this.positive,
    required this.inactive,
    required this.success,
    required this.failed,
    required this.warning,
    required this.info,
  });

  final Color cautionary;
  final Color negative;
  final Color positive;
  final Color inactive;
  final Color success;
  final Color failed;
  final Color warning;
  final Color info;

  factory AppColors.light() {
    return const AppColors(
      inactive: Color(0xffA3B1C6),
      positive: Color(0xff00bf40),
      cautionary: Color(0xffff9200),
      negative: Color(0xffff4242),
      success: Color(0xFF2E7D32),
      failed: Color(0xFFD32F2F),
      warning: Color(0xFFFFA000),
      info: Color(0xFF1976D2),
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      inactive: Color(0xff4A4D57),
      positive: Color(0xff1ed45a),
      cautionary: Color(0xffffa938),
      negative: Color(0xffff6363),
      success: Color(0xFF2E7D32),
      failed: Color(0xFFD32F2F),
      warning: Color(0xFFFFA000),
      info: Color(0xFF1976D2),
    );
  }

  @override
  AppColors copyWith({
    Color? cautionary,
    Color? negative,
    Color? positive,
    Color? inactive,
    Color? success,
    Color? failed,
    Color? warning,
    Color? info,
  }) {
    return AppColors(
      cautionary: cautionary ?? this.cautionary,
      negative: negative ?? this.negative,
      positive: positive ?? this.positive,
      inactive: inactive ?? this.inactive,
      success: success ?? this.success,
      failed: failed ?? this.failed,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      cautionary: Color.lerp(cautionary, other.cautionary, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      success: Color.lerp(success, other.success, t)!,
      failed: Color.lerp(failed, other.failed, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
