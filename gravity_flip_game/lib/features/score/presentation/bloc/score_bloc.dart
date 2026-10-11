import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/score_entity.dart';
import '../../domain/usecases/get_high_scores_usecase.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';
import '../../domain/usecases/save_score_usecase.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({
    required this._getLeaderboardUseCase,
    required this._getHighScoresUseCase,
    required this._saveScoreUseCase,
  }) : super(const ScoreInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<LoadHighScores>(_onLoadHighScores);
    on<SaveScore>(_onSaveScore);
    on<RefreshLeaderboard>(_onRefreshLeaderboard);
  }

  final GetLeaderboardUseCase _getLeaderboardUseCase;
  final GetHighScoresUseCase _getHighScoresUseCase;
  final SaveScoreUseCase _saveScoreUseCase;

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<ScoreState> emit,
  ) async {
    emit(const ScoreLoading());

    try {
      final scores = await _getLeaderboardUseCase(
        levelId: event.levelId,
        limit: event.limit,
      );
      emit(ScoreLoaded(scores: scores));
    } catch (error) {
      emit(ScoreFailure('Failed to load leaderboard: $error'));
    }
  }

  Future<void> _onLoadHighScores(
    LoadHighScores event,
    Emitter<ScoreState> emit,
  ) async {
    emit(const ScoreLoading());

    try {
      final scores = await _getHighScoresUseCase(levelId: event.levelId);
      emit(ScoreLoaded(scores: scores, source: 'high_scores'));
    } catch (error) {
      emit(ScoreFailure('Failed to load high scores: $error'));
    }
  }

  Future<void> _onSaveScore(SaveScore event, Emitter<ScoreState> emit) async {
    emit(const ScoreLoading());

    try {
      await _saveScoreUseCase(event.score);
      emit(
        ScoreSaved('Score saved successfully for ${event.score.playerName}'),
      );
      add(LoadLeaderboard(levelId: event.score.levelId));
    } catch (error) {
      emit(ScoreFailure('Failed to save score: $error'));
    }
  }

  Future<void> _onRefreshLeaderboard(
    RefreshLeaderboard event,
    Emitter<ScoreState> emit,
  ) async {
    add(LoadLeaderboard(levelId: event.levelId, limit: event.limit));
  }
}
