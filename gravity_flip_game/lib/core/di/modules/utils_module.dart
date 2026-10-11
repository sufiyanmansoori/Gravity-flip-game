import 'package:get_it/get_it.dart';

import '../../utils/logger.dart';

class UtilsModule {
  const UtilsModule._();

  static void register(GetIt injector) {
    injector.registerLazySingleton<AppLogger>(() => AppLogger());
  }
}
