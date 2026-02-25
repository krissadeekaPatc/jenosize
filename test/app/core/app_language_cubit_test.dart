import 'package:jenosize/common/app_language.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late AppLanguageCubit cubit;
  late MockAppStorage mockAppStorage;

  setUp(() {
    mockAppStorage = MockAppStorage();
    cubit = AppLanguageCubit(mockAppStorage);
  });

  tearDown(() async {
    await cubit.close();
    Intl.defaultLocale = null;
  });

  group('AppLanguageCubit.getInstance', () {
    test('initializes with stored language', () async {
      when(
        () => mockAppStorage.getString(StorageKey.language.name),
      ).thenAnswer((_) async => 'th');

      await cubit.initialize();

      expect(cubit.state, AppLanguage.th);
      expect(Intl.defaultLocale, 'th');
      verify(
        () => mockAppStorage.getString(StorageKey.language.name),
      ).called(1);
    });
  });

  group('setLanguage', () {
    test('updates state and storage when language set to "th"', () async {
      when(
        () => mockAppStorage.setString(StorageKey.language.name, 'th'),
      ).thenAnswer((_) async {});

      await cubit.setLanguage(AppLanguage.th);

      expect(cubit.state, AppLanguage.th);
      expect(Intl.defaultLocale, 'th');

      verify(
        () => mockAppStorage.setString(StorageKey.language.name, 'th'),
      ).called(1);
    });
  });
}
