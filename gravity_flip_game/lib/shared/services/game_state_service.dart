import 'package:flutter/foundation.dart';

class GameStateService extends ChangeNotifier {
  GameStateService();

  String _currentLevelId = 'level_1';
  int _score = 0;
  int _lives = 3;
  bool _isPaused = false;
  bool _isGameOver = false;

  String get currentLevelId => _currentLevelId;
  int get score => _score;
  int get lives => _lives;
  bool get isPaused => _isPaused;
  bool get isGameOver => _isGameOver;

  void setLevel(String levelId) {
    _currentLevelId = levelId;
    notifyListeners();
  }

  void addScore(int points) {
    _score += points;
    notifyListeners();
  }

  void loseLife() {
    if (_lives > 0) {
      _lives--;
    }
    if (_lives <= 0) {
      _isGameOver = true;
    }
    notifyListeners();
  }

  void resetRound() {
    _score = 0;
    _lives = 3;
    _isPaused = false;
    _isGameOver = false;
    notifyListeners();
  }

  void setPaused(bool paused) {
    _isPaused = paused;
    notifyListeners();
  }
}
