import 'package:get_it/get_it.dart';

import 'modules/data_module.dart';
import 'modules/domain_module.dart';
import 'modules/presentation_module.dart';
import 'modules/services_module.dart';
import 'modules/utils_module.dart';

class InjectionContainer {
  InjectionContainer._();

  static final GetIt _injector = GetIt.instance;

  static GetIt get injector => _injector;

  static Future<void> initialize() async {
    DataModule.register(_injector);
    DomainModule.register(_injector);
    PresentationModule.register(_injector);
    ServicesModule.register(_injector);
    UtilsModule.register(_injector);
  }
}
