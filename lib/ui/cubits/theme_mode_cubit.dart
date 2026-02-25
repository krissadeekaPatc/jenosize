import 'package:app_template/domain/storages/app_storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  final AppStorage _appStorage;

  ThemeModeCubit(this._appStorage) : super(ThemeMode.system);

  Future<void> initialize() async {
    final rawValue = await _appStorage.getString(
      StorageKey.themeMode.name,
    );
    final themeMode = ThemeMode.values.firstWhereOrNull(
      (e) => e.name == rawValue,
    );
    emit(themeMode ?? ThemeMode.system);
  }

  Future<void> set(ThemeMode themeMode) {
    emit(themeMode);
    return _appStorage.setString(
      StorageKey.themeMode.name,
      themeMode.name,
    );
  }
}
