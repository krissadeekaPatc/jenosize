import 'package:jenosize/generated/app_localizations.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  Brightness get brightness => Theme.of(this).brightness;
  bool get isDarkMode => brightness == Brightness.dark;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppLanguageCubit get appLanguageCubit => read<AppLanguageCubit>();
  SessionCubit get sessionCubit => read<SessionCubit>();

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
}
