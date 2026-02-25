import 'package:app_template/app/initializers/dependencies_initializer.dart';
import 'package:app_template/app/router/app_routes.dart';
import 'package:app_template/ui/global_widgets/loading_overlay.dart';
import 'package:app_template/ui/screens/login/cubit/login_screen_cubit.dart';
import 'package:app_template/ui/screens/login/cubit/login_screen_state.dart';
import 'package:app_template/ui/utils/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginScreenCubit(loginWithEmailUseCase: getIt());
      },
      child: const LoginScreenView(),
    );
  }
}

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  late final LoginScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginScreenCubit>();
  }

  void _listener(BuildContext context, LoginScreenState state) {
    switch (state.status) {
      case LoginScreenStatus.initial:
      case LoginScreenStatus.loading:
      case LoginScreenStatus.ready:
        break;

      case LoginScreenStatus.success:
        context.go(AppRoutes.dashboard);

      case LoginScreenStatus.failure:
        AppAlert.error(context, error: state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenCubit, LoginScreenState>(
      listener: _listener,
      child: BlocSelector<LoginScreenCubit, LoginScreenState, bool>(
        selector: (state) => state.status.isLoading,
        builder: (context, isLoading) {
          return LoadingOverlay(
            isLoading: isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Login'),
                centerTitle: true,
              ),
              body: Center(
                child: TextButton(
                  onPressed: () {
                    _cubit.skipLogin();
                  },
                  child: const Text('Skip'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
