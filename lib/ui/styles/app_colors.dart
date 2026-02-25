import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color inactive;
  final Color positive;
  final Color cautionary;
  final Color negative;

  const AppColors({
    required this.inactive,
    required this.positive,
    required this.cautionary,
    required this.negative,
  });

  factory AppColors.light() {
    return const AppColors(
      inactive: Color(0xffA3B1C6),
      positive: Color(0xff00bf40),
      cautionary: Color(0xffff9200),
      negative: Color(0xffff4242),
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      inactive: Color(0xff4A4D57),
      positive: Color(0xff1ed45a),
      cautionary: Color(0xffffa938),
      negative: Color(0xffff6363),
    );
  }

  @override
  AppColors copyWith({
    Color? inactive,
    Color? positive,
    Color? cautionary,
    Color? negative,
  }) {
    return AppColors(
      inactive: inactive ?? this.inactive,
      positive: positive ?? this.positive,
      cautionary: cautionary ?? this.cautionary,
      negative: negative ?? this.negative,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      inactive: Color.lerp(inactive, other.inactive, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      cautionary: Color.lerp(cautionary, other.cautionary, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
    );
  }
}
