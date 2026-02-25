import 'dart:ui';

import 'package:app_template/common/app_language.dart';
import 'package:app_template/domain/storages/app_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppLanguageCubit extends Cubit<AppLanguage> {
  final AppStorage _appStorage;

  AppLanguageCubit(this._appStorage) : super(AppLanguage.en);

  Future<void> initialize() async {
    String? languageCode = await _appStorage.getString(
      StorageKey.language.name,
    );
    languageCode ??= PlatformDispatcher.instance.locale.languageCode;
    final language = AppLanguage.fromLanguageCode(languageCode);
    Intl.defaultLocale = language.languageCode;
    emit(language);
  }

  Future<void> setLanguage(AppLanguage language) {
    emit(language);
    Intl.defaultLocale = language.languageCode;
    return _appStorage.setString(
      StorageKey.language.name,
      language.languageCode,
    );
  }
}
