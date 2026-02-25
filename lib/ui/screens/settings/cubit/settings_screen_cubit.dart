import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/domain/storages/token_vault.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/screens/settings/cubit/settings_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  final SessionCubit sessionCubit;
  final TokenVault tokenVault;
  final AppStorage appStorage;

  SettingsScreenCubit({
    required this.sessionCubit,
    required this.tokenVault,
    required this.appStorage,
  }) : super(const SettingsScreenState());

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(
      state.copyWith(
        appName: packageInfo.appName,
        version: '${packageInfo.version} (${packageInfo.buildNumber})',
      ),
    );
  }

  Future<void> logout() async {
    emit(state.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    await tokenVault.clearAll();
    sessionCubit.clearData();
    emit(state.success());
  }
}
