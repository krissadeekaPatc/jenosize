final class Env {
  Env._();

  static const bool testMode = bool.fromEnvironment('TEST_MODE');
  static const String baseUrl = String.fromEnvironment('BASE_URL');
}
