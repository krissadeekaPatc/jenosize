import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize/app/initializers/dependencies_initializer.dart';
import 'package:jenosize/app/router/app_routes.dart';
import 'package:jenosize/domain/use_cases/splash_use_case.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_cubit.dart';
import 'package:jenosize/ui/screens/splash/cubit/splash_screen_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashScreenCubit(
          sessionCubit: getIt(),
          useCase: SplashScreenUseCase(
            tokenVault: getIt(),
            userRepository: getIt(),
            sessionCubit: getIt(),
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
}
