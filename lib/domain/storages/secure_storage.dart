abstract class SecureStorage {
  /// Checks if the storage contains the given key.
  Future<bool> containsKey(String key);

  /// Writes a string value for the given key.
  Future<void> write(String key, String? value);

  /// Reads a string value for the given key.
  Future<String?> read(String key);

  /// Deletes the value associated with the given key.
  Future<void> delete(String key);

  /// Deletes all keys and values from the storage.
  Future<void> deleteAll();
}
