import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize/app/router/app_routes.dart';
import 'package:jenosize/common/app_language.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:jenosize/ui/cubits/theme_mode_cubit.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/screens/settings/cubit/settings_screen_cubit.dart';
import 'package:jenosize/ui/screens/settings/cubit/settings_screen_state.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';
import 'package:jenosize/ui/utils/app_alert.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  late final SettingsScreenCubit _cubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SettingsScreenCubit>();
    _cubit.init();
  }

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
      case SettingsScreenStatus.success:
        context.go(AppRoutes.splash);
      case SettingsScreenStatus.failure:
        AppAlert.error(context, error: state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsScreenCubit, SettingsScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        context.l10n.settings_title,
        style: AppTextStyle.w700(20).colorOnSurface(context),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppearanceSection(),
            const SizedBox(height: 32),
            _buildLanguageSection(),
            const SizedBox(height: 32),
            _buildAccountSection(),
            const SizedBox(height: 40),
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context.l10n.settings_section_appearance),
        const SizedBox(height: 12),
        _buildCardContainer(
          child: BlocSelector<ThemeModeCubit, ThemeMode, ThemeMode>(
            selector: (currentMode) => currentMode,
            builder: (context, currentMode) {
              return Column(
                children: ThemeMode.values.map((mode) {
                  return _buildThemeItem(mode, currentMode == mode);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context.l10n.settings_section_language),
        const SizedBox(height: 12),
        _buildCardContainer(
          child: BlocSelector<AppLanguageCubit, AppLanguage, AppLanguage>(
            selector: (state) => state,
            builder: (context, currentLanguage) {
              return Column(
                children: [
                  _buildLanguageItem(
                    label: context.l10n.settings_language_en,
                    isSelected: currentLanguage == AppLanguage.en,
                    onTap: () => context.read<AppLanguageCubit>().setLanguage(
                      AppLanguage.en,
                    ),
                  ),
                  _buildDivider(indent: 20),
                  _buildLanguageItem(
                    label: context.l10n.settings_language_th,
                    isSelected: currentLanguage == AppLanguage.th,
                    onTap: () => context.read<AppLanguageCubit>().setLanguage(
                      AppLanguage.th,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context.l10n.settings_section_account),
        const SizedBox(height: 12),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyle.w700(13).copyWith(
          color: context.colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: child,
    );
  }

  Widget _buildDivider({double indent = 56}) {
    return Divider(
      indent: indent,
      endIndent: 20,
      height: 1,
      color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
    );
  }

  Widget _buildThemeItem(ThemeMode mode, bool isSelected) {
    final isLast = mode == ThemeMode.values.last;
    final icon = {
      ThemeMode.system: Icons.brightness_auto_rounded,
      ThemeMode.light: Icons.light_mode_rounded,
      ThemeMode.dark: Icons.dark_mode_rounded,
    }[mode]!;

    final String modeLabel = {
      ThemeMode.system: context.l10n.settings_theme_system,
      ThemeMode.light: context.l10n.settings_theme_light,
      ThemeMode.dark: context.l10n.settings_theme_dark,
    }[mode]!;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.onSurfaceVariant,
          ),
          title: Text(
            modeLabel,
            style: AppTextStyle.w500(16).colorOnSurface(context),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle_rounded,
                  color: context.colorScheme.primary,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: () => context.read<ThemeModeCubit>().set(mode),
        ),
        if (!isLast) _buildDivider(),
      ],
    );
  }

  Widget _buildLanguageItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(label, style: AppTextStyle.w500(16).colorOnSurface(context)),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: context.colorScheme.primary)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return ListTile(
      leading: Icon(Icons.logout_rounded, color: context.appColors.negative),
      title: Text(
        context.l10n.settings_button_logout,
        style: AppTextStyle.w600(
          16,
        ).copyWith(color: context.appColors.negative),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.appColors.negative.withValues(alpha: 0.2),
        ),
      ),
      onTap: () => _cubit.logout(),
    );
  }

  Widget _buildFooterInfo() {
    return BlocSelector<
      SettingsScreenCubit,
      SettingsScreenState,
      (String, String)
    >(
      selector: (state) => (state.appName, state.version),
      builder: (context, info) {
        final (appName, version) = info;
        return Center(
          child: Column(
            children: [
              Text(
                appName,
                style: AppTextStyle.w600(14).colorOnSurface(context),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.settings_version_label(version),
                style: AppTextStyle.w400(12).colorOnSurfaceVariant(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
