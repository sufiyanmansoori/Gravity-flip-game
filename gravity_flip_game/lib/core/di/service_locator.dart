import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/ads/data/datasources/ads_datasource.dart';
import '../../features/ads/data/repositories/ads_repository_impl.dart';
import '../../features/ads/domain/repositories/ads_repository.dart';
import '../../features/audio/data/datasources/audio_local_datasource.dart';
import '../../features/audio/data/repositories/audio_repository_impl.dart';
import '../../features/audio/domain/repositories/audio_repository.dart';
import '../../features/notifications/data/datasources/notification_local_datasource.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../config/app_config.dart';
import '../config/env_config.dart';
import '../config/firebase_config.dart';
import '../config/game_config.dart';
import '../theme/theme_provider.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt instance = GetIt.instance;

  static Future<void> initialize({
    AppConfig? appConfig,
    EnvConfig? envConfig,
    FirebaseConfig? firebaseConfig,
    GameConfig? gameConfig,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (instance.isRegistered<AppConfig>()) {
      await instance.unregister<AppConfig>();
    }
    if (instance.isRegistered<EnvConfig>()) {
      await instance.unregister<EnvConfig>();
    }
    if (instance.isRegistered<FirebaseConfig>()) {
      await instance.unregister<FirebaseConfig>();
    }
    if (instance.isRegistered<GameConfig>()) {
      await instance.unregister<GameConfig>();
    }

    instance.registerLazySingleton<AppConfig>(() => appConfig ?? AppConfig());
    instance.registerLazySingleton<EnvConfig>(
      () => envConfig ?? const EnvConfig(),
    );
    instance.registerLazySingleton<FirebaseConfig>(
      () => firebaseConfig ?? const FirebaseConfig(),
    );
    instance.registerLazySingleton<GameConfig>(
      () => gameConfig ?? const GameConfig(),
    );
    instance.registerLazySingleton<ThemeProvider>(
      () => ThemeProvider(preferences: prefs),
    );
    instance.registerLazySingleton<AudioLocalDataSource>(
      () => AudioLocalDataSource(preferences: prefs),
    );
    instance.registerLazySingleton<AudioRepository>(
      () => AudioRepositoryImpl(
        localDataSource: instance.get<AudioLocalDataSource>(),
      ),
    );
    instance.registerLazySingleton<NotificationLocalDataSource>(
      () => NotificationLocalDataSource(preferences: prefs),
    );
    instance.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        localDataSource: instance.get<NotificationLocalDataSource>(),
      ),
    );
    await instance.get<NotificationRepository>().initialize();
    instance.registerLazySingleton<AdsDataSource>(() => const AdsDataSource());
    instance.registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImpl(dataSource: instance.get<AdsDataSource>()),
    );

    final themeProvider = instance.get<ThemeProvider>();
    await themeProvider.initialize();
  }

  static void reset() {
    instance.reset();
  }
}
