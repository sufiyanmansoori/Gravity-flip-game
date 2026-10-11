import 'package:flutter/widgets.dart';

class AppNavigationObserver extends NavigatorObserver {
  AppNavigationObserver();

  void _log(
    String event,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) {
    final currentName = route?.settings.name ?? '<unnamed>';
    final previousName = previousRoute?.settings.name ?? '<none>';
    debugPrint('[$event] $previousName -> $currentName');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _log('push', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _log('pop', route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _log('remove', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _log('replace', newRoute, oldRoute);
  }
}
