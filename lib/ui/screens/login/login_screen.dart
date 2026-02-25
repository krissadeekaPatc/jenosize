import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize/app/initializers/dependencies_initializer.dart';
import 'package:jenosize/app/router/app_routes.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/global_widgets/loading_overlay.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_cubit.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_state.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';
import 'package:jenosize/ui/utils/app_alert.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginScreenCubit(getIt());
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginScreenCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _listener(BuildContext context, LoginScreenState state) {
    switch (state.status) {
      case LoginScreenStatus.initial:
      case LoginScreenStatus.loading:
        break;
      case LoginScreenStatus.success:
        context.go(AppRoutes.main);
      case LoginScreenStatus.failure:
        AppAlert.error(context, error: state.error);
    }
  }

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.login_error_empty_fields)),
      );
      return;
    }

    _cubit.login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenCubit, LoginScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.isLoading,
          child: _buildScaffold(),
        );
      },
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Icon(
                Icons.account_circle_rounded,
                size: 100,
                color: context.colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                context.l10n.login_welcome_back,
                textAlign: TextAlign.center,
                style: AppTextStyle.w800(28).colorOnSurface(context),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.login_sign_in_to_continue,
                textAlign: TextAlign.center,
                style: AppTextStyle.w400(16).colorOnSurfaceVariant(context),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: context.l10n.login_label_email,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: context.l10n.login_label_password,
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 56,
                child: FilledButton(
                  onPressed: _onLoginPressed,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    context.l10n.login_button_submit,
                    style: AppTextStyle.w700(18).colorOnPrimary(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
