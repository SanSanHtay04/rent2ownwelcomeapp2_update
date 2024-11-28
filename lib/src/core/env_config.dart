class EnvConfig {
  const EnvConfig._();
  static const serverUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'https://mmsys-be.vnapp.xyz',
  );

  static const baseUrl = '$serverUrl/api/welcome-app/v1';

  static const String logLevel =
      String.fromEnvironment('LOG_LEVEL', defaultValue: 'info');

  static const bool isProd =
      bool.fromEnvironment("IS_PROD", defaultValue: false);
}
