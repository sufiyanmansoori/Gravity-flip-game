import 'package:get_it/get_it.dart';

import '../../config/difficulty_config.dart';

class DomainModule {
  const DomainModule._();

  static void register(GetIt injector) {
    injector.registerLazySingleton<String>(() => 'domain');
    injector.registerLazySingleton<List<Map<String, dynamic>>>(
      () => DifficultyConfig.presets,
    );
  }
}
