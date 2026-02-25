import 'package:app_template/app/router/app_routes.dart';
import 'package:app_template/ui/screens/body_age/body_age_screen.dart';
import 'package:app_template/ui/screens/dashboard/dashboard_screen.dart';
import 'package:app_template/ui/screens/login/login_screen.dart';
import 'package:app_template/ui/screens/product/product_screen.dart';
import 'package:app_template/ui/screens/products/products_screen.dart';
import 'package:app_template/ui/screens/splash/splash_screen.dart';
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
        path: AppRoutes.dashboard,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.products,
        builder: (context, state) {
          return const ProductsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return ProductScreen(productId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.bodyAge,
        builder: (context, state) {
          return const BodyAgeScreen();
        },
      ),
    ],
  );
}
