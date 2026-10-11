part of 'score_bloc.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();
}

class ScoreInitial extends ScoreState {
  const ScoreInitial();

  @override
  List<Object?> get props => const [];
}

class ScoreLoading extends ScoreState {
  const ScoreLoading();

  @override
  List<Object?> get props => const [];
}

class ScoreLoaded extends ScoreState {
  const ScoreLoaded({
    required this.scores,
    this.selectedScore,
    this.source = 'leaderboard',
  });

  final List<ScoreEntity> scores;
  final ScoreEntity? selectedScore;
  final String source;

  @override
  List<Object?> get props => [scores, selectedScore, source];
}

class ScoreSaved extends ScoreState {
  const ScoreSaved(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ScoreFailure extends ScoreState {
  const ScoreFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
