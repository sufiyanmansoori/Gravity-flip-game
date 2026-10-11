class RouteNames {
  const RouteNames._();

  static const String splash = '/';
  static const String mainMenu = '/main-menu';
  static const String settings = '/settings';
  static const String tutorial = '/tutorial';
  static const String achievements = '/achievements';
  static const String skins = '/skins';
  static const String levelSelect = '/level-select';
  static const String game = '/game';
  static const String gameOver = '/game-over';
  static const String login = '/login';
  static const String notFound = '/not-found';

  static const List<String> protectedRoutes = <String>[game, gameOver];
}
