import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum AppLanguage {
  en,
  th;

  factory AppLanguage.fromLanguageCode(String languageCode) {
    return AppLanguage.values.firstWhereOrNull(
          (e) => e.languageCode == languageCode,
        ) ??
        AppLanguage.en;
  }

  String get languageCode {
    return name;
  }

  Locale get locale {
    return Locale(languageCode);
  }
}
