import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle get _base => const TextStyle();

  /// Thin
  static TextStyle w100(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w100, fontSize: fontSize);

  /// ExtraLight
  static TextStyle w200(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w200, fontSize: fontSize);

  /// Light
  static TextStyle w300(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w300, fontSize: fontSize);

  /// Regular
  static TextStyle w400(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w400, fontSize: fontSize);

  /// Medium
  static TextStyle w500(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w500, fontSize: fontSize);

  /// SemiBold
  static TextStyle w600(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize);

  /// Bold
  static TextStyle w700(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w700, fontSize: fontSize);

  /// ExtraBold
  static TextStyle w800(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w800, fontSize: fontSize);

  /// Black
  static TextStyle w900(double fontSize) =>
      _base.copyWith(fontWeight: FontWeight.w900, fontSize: fontSize);
}

extension TextStyleExtension on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline =>
      copyWith(decoration: TextDecoration.underline, decorationColor: color);

  TextStyle get lineThrough =>
      copyWith(decoration: TextDecoration.lineThrough, decorationColor: color);

  TextStyle withAlpha(double alpha) =>
      copyWith(color: color?.withValues(alpha: alpha));

  TextStyle colorPrimary(BuildContext context) =>
      copyWith(color: context.colorScheme.primary);

  TextStyle colorSecondary(BuildContext context) =>
      copyWith(color: context.colorScheme.secondary);

  TextStyle colorTertiary(BuildContext context) =>
      copyWith(color: context.colorScheme.tertiary);

  TextStyle colorError(BuildContext context) =>
      copyWith(color: context.colorScheme.error);

  TextStyle colorOnPrimary(BuildContext context) =>
      copyWith(color: context.colorScheme.onPrimary);

  TextStyle colorOnSecondary(BuildContext context) =>
      copyWith(color: context.colorScheme.onSecondary);

  TextStyle colorOnTertiary(BuildContext context) =>
      copyWith(color: context.colorScheme.onTertiary);

  TextStyle colorOnPrimaryContainer(BuildContext context) =>
      copyWith(color: context.colorScheme.onPrimaryContainer);

  TextStyle colorOnSecondaryContainer(BuildContext context) =>
      copyWith(color: context.colorScheme.onSecondaryContainer);

  TextStyle colorOnTertiaryContainer(BuildContext context) =>
      copyWith(color: context.colorScheme.onTertiaryContainer);

  TextStyle colorOnSurface(BuildContext context) =>
      copyWith(color: context.colorScheme.onSurface);

  TextStyle colorOnSurfaceVariant(BuildContext context) =>
      copyWith(color: context.colorScheme.onSurfaceVariant);

  TextStyle colorPositive(BuildContext context) =>
      copyWith(color: context.appColors.positive);

  TextStyle colorCautionary(BuildContext context) =>
      copyWith(color: context.appColors.cautionary);

  TextStyle colorNegative(BuildContext context) =>
      copyWith(color: context.appColors.negative);
}
