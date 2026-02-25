import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize/app/initializers/dependencies_initializer.dart';
import 'package:jenosize/app/router/app_routes.dart';
import 'package:jenosize/common/app_language.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
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
      create: (context) => LoginScreenCubit(getIt()),
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

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
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _onLanguageToggle() {
    final cubit = context.read<AppLanguageCubit>();
    final nextLanguage = cubit.state == AppLanguage.en
        ? AppLanguage.th
        : AppLanguage.en;
    cubit.setLanguage(nextLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenCubit, LoginScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.isLoading,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      _buildContent(),
                      _buildLanguageToggle(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 48),
          _buildLogo(),
          const SizedBox(height: 32),
          _buildHeader(),
          const SizedBox(height: 48),
          _buildForm(),
          const SizedBox(height: 40),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Icon(
      Icons.account_circle_rounded,
      size: 100,
      color: context.colorScheme.primary,
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autovalidateMode: .onUserInteraction,
          decoration: InputDecoration(
            labelText: context.l10n.login_label_email,
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.l10n.login_error_empty_fields;
            }
            if (!_emailRegex.hasMatch(value)) {
              return context.l10n.login_error_invalid_email;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          autovalidateMode: .onUserInteraction,
          onFieldSubmitted: (_) => _onLoginPressed(),
          decoration: InputDecoration(
            labelText: context.l10n.login_label_password,
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.l10n.login_error_empty_fields;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
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
    );
  }

  Widget _buildLanguageToggle() {
    return Positioned(
      top: 8,
      right: 16,
      child: BlocSelector<AppLanguageCubit, AppLanguage, String>(
        selector: (state) => state.languageCode.toUpperCase(),
        builder: (context, langCode) {
          return TextButton.icon(
            onPressed: _onLanguageToggle,
            icon: const Icon(Icons.language_rounded, size: 20),
            label: Text(
              langCode,
              style: AppTextStyle.w700(14).colorOnSurface(context),
            ),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
            ),
          );
        },
      ),
    );
  }
}
