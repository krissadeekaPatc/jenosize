enum StorageKey {
  firstOpenEpoch,
  language,
  themeMode,
}

abstract class AppStorage {
  /// Checks if the storage contains the given key.
  Future<bool> containsKey(String key);

  /// Sets a string value for the given key.
  Future<void> setString(String key, String value);

  /// Gets a string value for the given key.
  Future<String?> getString(String key);

  /// Sets a int value for the given key.
  Future<void> setInt(String key, int value);

  /// Gets a int value for the given key.
  Future<int?> getInt(String key);

  /// Sets a boolean value for the given key.
  Future<void> setBool(String key, bool value);

  /// Gets a boolean value for the given key.
  Future<bool?> getBool(String key);

  /// Sets a JSON object for the given key.
  Future<void> setJson(String key, Map<String, dynamic> json);

  /// Gets a JSON object for the given key.
  Future<Map<String, dynamic>?> getJson(String key);

  /// Generic method to get an object of type T from storage.
  Future<T?> getObject<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  });

  /// Removes the value associated with the given key.
  Future<void> remove(String key);
}
