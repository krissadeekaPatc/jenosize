import 'package:app_template/data/models/auth.dart';

enum TokenVaultKey {
  accessToken,
  refreshToken,
}

abstract class TokenVault {
  /// Sets both access and refresh tokens.
  Future<void> setAuth(Auth auth);

  /// Checks if access token exists.
  Future<bool> hasAccessToken();

  /// Gets the access token securely.
  Future<String?> getAccessToken();

  /// Gets the refresh token securely.
  Future<String?> getRefreshToken();

  /// Clears all secure storage.
  Future<void> clearAll();
}
