class MockData {
  const MockData._();

  static const Map<String, dynamic> gamePayload = {
    'id': 'game_001',
    'score': 1200,
    'bestScore': 1800,
    'lives': 3,
    'currentLevel': 1,
    'state': 'ready',
  };

  static const Map<String, dynamic> levelPayload = {
    'number': 1,
    'name': 'Neon Drift',
    'difficulty': 'easy',
    'speed': 180,
    'gravity': 1800,
    'obstacles': [
      {'x': 100, 'y': 200, 'width': 100, 'height': 20},
    ],
    'collectibles': [
      {'x': 150, 'y': 150, 'value': 50},
    ],
    'baseScore': 1000,
  };

  static const List<Map<String, dynamic>> leaderboardPayload = [
    {
      'id': 'score_001',
      'playerName': 'Player One',
      'score': 1200,
      'levelId': 'level_1',
      'levelName': 'Neon Drift',
      'rank': 1,
      'createdAt': '2025-01-01T00:00:00.000Z',
    },
    {
      'id': 'score_002',
      'playerName': 'Player Two',
      'score': 900,
      'levelId': 'level_1',
      'levelName': 'Neon Drift',
      'rank': 2,
      'createdAt': '2025-01-02T00:00:00.000Z',
    },
  ];

  static const List<Map<String, dynamic>> achievementPayload = [
    {
      'id': 'first_launch',
      'title': 'First Launch',
      'description': 'Open the game for the first time.',
      'icon': '🚀',
      'category': 'general',
      'progress': 1,
      'target': 1,
      'isUnlocked': true,
      'unlockedAt': '2025-01-01T00:00:00.000Z',
      'rarity': 'common',
      'createdAt': '2025-01-01T00:00:00.000Z',
    },
  ];
}
