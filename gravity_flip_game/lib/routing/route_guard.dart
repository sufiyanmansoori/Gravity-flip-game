import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../shared/services/auth_service.dart';
import 'route_names.dart';

class RouteGuard {
  const RouteGuard({this._authService});

  final AuthService? _authService;

  bool get isAuthenticated => _authService?.isAuthenticated ?? true;

  String? redirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;
    final requiresAuth = _isProtectedRoute(location);

    if (requiresAuth && !isAuthenticated) {
      return RouteNames.mainMenu;
    }

    return null;
  }

  bool _isProtectedRoute(String location) {
    return RouteNames.protectedRoutes.contains(location) ||
        location.startsWith('${RouteNames.game}/') ||
        location.startsWith('${RouteNames.gameOver}/');
  }
}
