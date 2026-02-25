import 'package:app_template/app/initializers/dependencies_initializer.dart';
import 'package:app_template/app/router/app_routes.dart';
import 'package:app_template/common/app_utils.dart';
import 'package:app_template/domain/use_cases/splash_use_case.dart';
import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:app_template/ui/screens/splash/cubit/splash_screen_cubit.dart';
import 'package:app_template/ui/screens/splash/cubit/splash_screen_state.dart';
import 'package:app_template/ui/utils/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final sessionCubit = context.sessionCubit;
        return SplashScreenCubit(
          sessionCubit: sessionCubit,
          useCase: SplashScreenUseCase(
            tokenVault: getIt(),
            storeVersionRepository: getIt(),
            userRepository: getIt(),
          ),
        );
      },
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  late final SplashScreenCubit _cubit;

  @override
  void initState() {
    _cubit = context.read();
    super.initState();
    _cubit.initialize();
  }

  void _listener(BuildContext context, SplashScreenState state) {
    switch (state.status) {
      case SplashScreenStatus.initial:
        break;

      case SplashScreenStatus.newVersionAvailable:
        final appStoreLink = state.appStoreLink;
        if (appStoreLink == null) return;
        _alertNewVersionAvailable(
          appStoreLink: appStoreLink,
          storeVersion: state.storeVersion,
        );

      case SplashScreenStatus.authenticated:
        context.go(AppRoutes.main);

      case SplashScreenStatus.unauthenticated:
        context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenCubit, SplashScreenState>(
      listener: _listener,
      child: const Scaffold(body: Center(child: Text('Splash'))),
    );
  }

  void _alertNewVersionAvailable({
    required String appStoreLink,
    required String? storeVersion,
  }) {
    AppAlert.dialog(
      context,
      title: context.l10n.new_version_available_dialog_title,
      message: context.l10n.new_version_available_dialog_message(
        storeVersion ?? '',
      ),
      barrierDismissible: false,
      onAction: () {
        AppUtils.launchUrlString(
          appStoreLink,
          mode: LaunchMode.externalApplication,
        );
      },
    );
  }
}
