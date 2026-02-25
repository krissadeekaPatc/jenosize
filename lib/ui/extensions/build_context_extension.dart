import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/ui/cubits/app_language_cubit.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:app_template/ui/cubits/theme_mode_cubit.dart';
import 'package:app_template/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  ThemeModeCubit get themeModeCubit => read<ThemeModeCubit>();
  AppLanguageCubit get appLanguageCubit => read<AppLanguageCubit>();
  SessionCubit get sessionCubit => read<SessionCubit>();
}
