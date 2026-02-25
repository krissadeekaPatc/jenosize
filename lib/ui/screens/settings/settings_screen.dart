import 'package:app_template/app/router/app_routes.dart';
import 'package:app_template/ui/cubits/theme_mode_cubit.dart';
import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:app_template/ui/screens/settings/cubit/settings_screen_cubit.dart';
import 'package:app_template/ui/screens/settings/cubit/settings_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _listener(BuildContext context, SettingsScreenState state) {
    switch (state.status) {
      case SettingsScreenStatus.initial:
      case SettingsScreenStatus.loading:
      case SettingsScreenStatus.ready:
        break;

      case SettingsScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsScreenCubit, SettingsScreenState>(
      listener: _listener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings'), centerTitle: true),
        body: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              spacing: 16,
              children: [_themeModeSetting(), _logoutButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _themeModeSetting() {
    return ColoredBox(
      color: context.colorScheme.surfaceContainerHigh,
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) {
          return RadioGroup<ThemeMode>(
            groupValue: state,
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeModeCubit>().set(value);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: ThemeMode.values.map((e) {
                return RadioListTile<ThemeMode>(
                  title: Text(e.name),
                  value: e,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _logoutButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          context.go(AppRoutes.splash);
        },
        child: const Text('Logout'),
      ),
    );
  }
}
