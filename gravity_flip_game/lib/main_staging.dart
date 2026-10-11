import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.initialize(
    appConfig: AppConfig(
      appName: 'Gravity Flip Staging',
      version: '1.0.0-staging',
      debugMode: true,
      isProduction: false,
    ),
    envConfig: const EnvConfig(
      environment: 'staging',
      apiBaseUrl: 'https://staging-api.gravityflipgame.com',
      enableAnalytics: true,
      enableCrashlytics: true,
      enableRemoteConfig: true,
    ),
  );

  runApp(const GravityFlipApp());
}
