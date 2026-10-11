import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/achievements_screen.dart';
import '../screens/game_over_screen.dart';
import '../screens/game_screen.dart';
import '../screens/level_select_screen.dart';
import '../screens/main_menu_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/skins_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/tutorial_screen.dart';
import '../shared/services/auth_service.dart';
import 'navigation_observer.dart';
import 'route_guard.dart';
import 'route_names.dart';
import 'transitions/fade_transition.dart';
import 'transitions/slide_transition.dart';

class AppRouter {
  AppRouter._();

  static final AuthService _authService = AuthService();
  static final RouteGuard _routeGuard = RouteGuard(authService: _authService);

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[AppNavigationObserver()],
    redirect: (context, state) => _routeGuard.redirect(context, state),
    routes: <RouteBase>[
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.mainMenu,
        name: RouteNames.mainMenu,
        pageBuilder: (context, state) => fadeTransitionPage(
          key: state.pageKey,
          child: const MainMenuScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settings,
        pageBuilder: (context, state) => slideTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.tutorial,
        name: RouteNames.tutorial,
        pageBuilder: (context, state) => fadeTransitionPage(
          key: state.pageKey,
          child: const TutorialScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.achievements,
        name: RouteNames.achievements,
        pageBuilder: (context, state) => slideTransitionPage(
          key: state.pageKey,
          child: const AchievementsScreen(),
          begin: const Offset(0, 1),
        ),
      ),
      GoRoute(
        path: RouteNames.skins,
        name: RouteNames.skins,
        pageBuilder: (context, state) =>
            fadeTransitionPage(key: state.pageKey, child: const SkinsScreen()),
      ),
      GoRoute(
        path: RouteNames.levelSelect,
        name: RouteNames.levelSelect,
        pageBuilder: (context, state) => slideTransitionPage(
          key: state.pageKey,
          child: const LevelSelectScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.game,
        name: RouteNames.game,
        pageBuilder: (context, state) {
          final worldIndex =
              int.tryParse(state.uri.queryParameters['world'] ?? '1') ?? 1;
          final levelNumber =
              int.tryParse(state.uri.queryParameters['level'] ?? '1') ?? 1;

          return fadeTransitionPage(
            key: state.pageKey,
            child: GameScreen(worldIndex: worldIndex, levelNumber: levelNumber),
          );
        },
      ),
      GoRoute(
        path: RouteNames.gameOver,
        name: RouteNames.gameOver,
        pageBuilder: (context, state) {
          final score =
              int.tryParse(state.uri.queryParameters['score'] ?? '0') ?? 0;
          final best =
              int.tryParse(state.uri.queryParameters['best'] ?? '0') ?? 0;

          return slideTransitionPage(
            key: state.pageKey,
            child: GameOverScreen(score: score, bestScore: best),
            begin: const Offset(0, 1),
          );
        },
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        pageBuilder: (context, state) => fadeTransitionPage(
          key: state.pageKey,
          child: const MainMenuScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => fadeTransitionPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 52,
                  color: Colors.white70,
                ),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.error?.toString() ??
                      'The requested route does not exist.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: Colors.white60),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => context.go(RouteNames.mainMenu),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Back to menu'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  static void goToMainMenu(BuildContext context) =>
      context.go(RouteNames.mainMenu);
  static void goToSettings(BuildContext context) =>
      context.go(RouteNames.settings);
  static void goToTutorial(BuildContext context) =>
      context.go(RouteNames.tutorial);
  static void goToAchievements(BuildContext context) =>
      context.go(RouteNames.achievements);
  static void goToSkins(BuildContext context) => context.go(RouteNames.skins);
  static void goToLevelSelect(BuildContext context) =>
      context.go(RouteNames.levelSelect);

  static void goToGame(BuildContext context, {int world = 1, int level = 1}) {
    context.go('${RouteNames.game}?world=$world&level=$level');
  }

  static void goToGameOver(
    BuildContext context, {
    required int score,
    required int best,
  }) {
    context.go('${RouteNames.gameOver}?score=$score&best=$best');
  }
}
