import 'dart:convert';
import 'dart:developer' as dev;

import 'package:app_template/domain/storages/app_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageImpl implements AppStorage {
  final SharedPreferences _sharedPrefs;

  const AppStorageImpl(this._sharedPrefs);

  @override
  Future<bool> containsKey(String key) async {
    return _sharedPrefs.containsKey(key);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _sharedPrefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPrefs.getString(key);
  }

  @override
  Future<void> setInt(String key, int value) {
    return _sharedPrefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _sharedPrefs.getInt(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return _sharedPrefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _sharedPrefs.getBool(key);
  }

  @override
  Future<void> setJson(String key, Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    return _sharedPrefs.setString(key, jsonString);
  }

  @override
  Future<Map<String, dynamic>?> getJson(String key) async {
    final jsonString = _sharedPrefs.getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString);
    } catch (error, stackTrace) {
      _log(
        'Failed to decode JSON from SharedPreferences',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<T?> getObject<T>(
    String key, {
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final json = await getJson(key);
    if (json == null) return null;

    try {
      return fromJson(json);
    } catch (error, stackTrace) {
      _log(
        'Failed to decode model from JSON',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<bool> remove(String key) {
    return _sharedPrefs.remove(key);
  }

  void _log(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    dev.log(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
