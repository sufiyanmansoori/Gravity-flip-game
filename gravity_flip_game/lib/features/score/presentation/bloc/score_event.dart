part of 'score_bloc.dart';

abstract class ScoreEvent {
  const ScoreEvent();
}

class LoadLeaderboard extends ScoreEvent {
  const LoadLeaderboard({this.levelId, this.limit = 10});

  final String? levelId;
  final int limit;
}

class LoadHighScores extends ScoreEvent {
  const LoadHighScores({this.levelId});

  final String? levelId;
}

class SaveScore extends ScoreEvent {
  const SaveScore(this.score);

  final ScoreEntity score;
}

class RefreshLeaderboard extends ScoreEvent {
  const RefreshLeaderboard({this.levelId, this.limit = 10});

  final String? levelId;
  final int limit;
}
