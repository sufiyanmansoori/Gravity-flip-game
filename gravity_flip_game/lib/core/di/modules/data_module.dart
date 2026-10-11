import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../config/env_config.dart';
import '../../config/game_config.dart';

class DataModule {
  const DataModule._();

  static void register(GetIt injector) {
    injector.registerLazySingleton<AppConfig>(() => AppConfig());
    injector.registerLazySingleton<EnvConfig>(() => const EnvConfig());
    injector.registerLazySingleton<GameConfig>(() => const GameConfig());
  }
}
