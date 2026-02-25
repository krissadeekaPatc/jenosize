import 'package:app_template/data/models/auth.dart';
import 'package:app_template/domain/storages/secure_storage.dart';
import 'package:app_template/domain/storages/token_vault.dart';

class TokenVaultImpl implements TokenVault {
  final SecureStorage _secureStorage;

  String? _accessToken;

  TokenVaultImpl(this._secureStorage);

  @override
  Future<void> setAuth(Auth auth) async {
    _accessToken = auth.accessToken;
    await _secureStorage.write(
      TokenVaultKey.accessToken.name,
      auth.accessToken,
    );
    await _secureStorage.write(
      TokenVaultKey.refreshToken.name,
      auth.refreshToken,
    );
  }

  @override
  Future<bool> hasAccessToken() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  @override
  Future<String?> getAccessToken() async {
    if (_accessToken != null) {
      return _accessToken;
    }
    final accessToken = await _secureStorage.read(
      TokenVaultKey.accessToken.name,
    );
    _accessToken = accessToken;
    return accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final refreshToken = await _secureStorage.read(
      TokenVaultKey.refreshToken.name,
    );
    return refreshToken;
  }

  @override
  Future<void> clearAll() async {
    _accessToken = null;
    await _secureStorage.delete(TokenVaultKey.accessToken.name);
    await _secureStorage.delete(TokenVaultKey.refreshToken.name);
  }
}
