import 'package:app_template/domain/storages/app_storage.dart';
import 'package:app_template/ui/cubits/theme_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late ThemeModeCubit cubit;
  late MockAppStorage mockAppStorage;

  setUp(() {
    mockAppStorage = MockAppStorage();
    cubit = ThemeModeCubit(mockAppStorage);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('ThemeModeCubit.getInstance', () {
    test('initializes with stored ThemeMode.dark', () async {
      when(
        () => mockAppStorage.getString(StorageKey.themeMode.name),
      ).thenAnswer((_) async => 'dark');

      await cubit.initialize();

      expect(cubit.state, ThemeMode.dark);
      verify(
        () => mockAppStorage.getString(StorageKey.themeMode.name),
      ).called(1);
    });

    test('initializes with ThemeMode.system if stored value missing', () async {
      when(
        () => mockAppStorage.getString(StorageKey.themeMode.name),
      ).thenAnswer((_) async => null);

      await cubit.initialize();

      expect(cubit.state, ThemeMode.system);
      verify(
        () => mockAppStorage.getString(StorageKey.themeMode.name),
      ).called(1);
    });
  });

  group('setThemeMode', () {
    test('updates state and writes ThemeMode.light to storage', () async {
      when(
        () => mockAppStorage.getString(StorageKey.themeMode.name),
      ).thenAnswer((_) async => 'light');
      when(
        () => mockAppStorage.setString(StorageKey.themeMode.name, 'light'),
      ).thenAnswer((_) async {});

      await cubit.initialize();

      await cubit.set(ThemeMode.light);

      expect(cubit.state, ThemeMode.light);
      verify(
        () => mockAppStorage.setString(StorageKey.themeMode.name, 'light'),
      ).called(1);
    });
  });
}
