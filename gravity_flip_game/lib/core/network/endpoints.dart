class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.gravityflipgame.com';
  static const String auth = '/auth';
  static const String leaderboard = '/leaderboard';
  static const String achievements = '/achievements';
  static const String profile = '/profile';
  static const String skins = '/skins';
  static const String sessions = '/sessions';

  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String syncScore = '$leaderboard/score';
  static const String playerStats = '$profile/stats';
}
