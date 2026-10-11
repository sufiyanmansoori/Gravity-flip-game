class EnvConfig {
  const EnvConfig({
    this.environment = 'development',
    this.apiBaseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gravityflipgame.com',
    ),
    this.enableAnalytics = false,
    this.enableCrashlytics = false,
    this.enableRemoteConfig = false,
  });

  final String environment;
  final String apiBaseUrl;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final bool enableRemoteConfig;

  bool get isProduction => environment == 'production';
  bool get isDevelopment => environment == 'development';

  EnvConfig copyWith({
    String? environment,
    String? apiBaseUrl,
    bool? enableAnalytics,
    bool? enableCrashlytics,
    bool? enableRemoteConfig,
  }) {
    return EnvConfig(
      environment: environment ?? this.environment,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashlytics: enableCrashlytics ?? this.enableCrashlytics,
      enableRemoteConfig: enableRemoteConfig ?? this.enableRemoteConfig,
    );
  }
}
