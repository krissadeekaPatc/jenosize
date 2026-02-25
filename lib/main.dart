import 'package:app_template/app/initializers/dependencies_initializer.dart';
import 'package:app_template/app/router/app_router.dart';
import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/ui/cubits/app_language_cubit.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:app_template/ui/cubits/theme_mode_cubit.dart';
import 'package:app_template/ui/styles/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = true;

  // await initializeFirebase();

  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeModeCubit>()),
        BlocProvider(create: (_) => getIt<AppLanguageCubit>()),
        BlocProvider(create: (_) => getIt<SessionCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeModeCubit>().state;

    final appLanguage = context.watch<AppLanguageCubit>().state;

    return MaterialApp.router(
      themeMode: themeMode,
      theme: const AppTheme().light(),
      darkTheme: const AppTheme().dark(),
      routerConfig: AppRouter.router,
      locale: appLanguage.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
