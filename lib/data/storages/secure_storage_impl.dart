import 'dart:developer' as dev;

import 'package:jenosize/domain/storages/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _secureStorage;

  const SecureStorageImpl(this._secureStorage);

  @override
  Future<bool> containsKey(String key) async {
    try {
      final result = await _secureStorage.containsKey(key: key);
      return result;
    } catch (error, stackTrace) {
      _log(
        'SecureStorageImpl.containsKey failed',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> write(String key, String? value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (error, stackTrace) {
      _log(
        'SecureStorageImpl.write failed',
        error: error,
        stackTrace: stackTrace,
      );
      return;
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      final result = await _secureStorage.read(key: key);
      return result;
    } catch (error, stackTrace) {
      _log(
        'SecureStorageImpl.read failed',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (error, stackTrace) {
      _log(
        'SecureStorageImpl.delete failed',
        error: error,
        stackTrace: stackTrace,
      );
      return;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (error, stackTrace) {
      _log(
        'SecureStorageImpl.deleteAll failed',
        error: error,
        stackTrace: stackTrace,
      );
      return;
    }
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
