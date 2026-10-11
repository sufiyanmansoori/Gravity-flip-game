import 'package:get_it/get_it.dart';

import '../../theme/theme_provider.dart';

class PresentationModule {
  const PresentationModule._();

  static void register(GetIt injector) {
    injector.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  }
}
