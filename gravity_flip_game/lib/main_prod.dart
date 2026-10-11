import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.initialize(
    appConfig: AppConfig(),
    envConfig: const EnvConfig(
      environment: 'production',
      enableAnalytics: true,
      enableCrashlytics: true,
      enableRemoteConfig: true,
    ),
  );

  runApp(const GravityFlipApp());
}
