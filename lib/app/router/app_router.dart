import 'package:jenosize/app/router/app_routes.dart';
import 'package:jenosize/ui/screens/login/login_screen.dart';
import 'package:jenosize/ui/screens/main/main_screen.dart';
import 'package:jenosize/ui/screens/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) {
          return const MainScreen();
        },
      ),
    ],
  );
}
