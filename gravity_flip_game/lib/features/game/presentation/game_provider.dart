import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/datasources/game_local_datasource.dart';
import '../data/datasources/game_remote_datasource.dart';
import '../data/repositories/game_repository_impl.dart';
import '../domain/entities/game_entity.dart';
import '../domain/usecases/load_level_usecase.dart';
import '../domain/usecases/start_game_usecase.dart';

class GameProvider extends ChangeNotifier {
  GameProvider() {
    final local = GameLocalDataSource();
    final remote = GameRemoteDataSource();
    final repository = GameRepositoryImpl(
      localDataSource: local,
      remoteDataSource: remote,
    );

    _startGameUseCase = StartGameUseCase(repository);
    _loadLevelUseCase = LoadLevelUseCase(repository);
    _repository = repository;
    _loadInitialGame();
  }

  late final StartGameUseCase _startGameUseCase;
  late final LoadLevelUseCase _loadLevelUseCase;
  late final GameRepositoryImpl _repository;

  GameEntity? _game;
  bool _isLoading = false;
  String? _error;

  GameEntity? get game => _game;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> startGame() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _game = await _startGameUseCase();
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLevel(int levelNumber) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updated = await _loadLevelUseCase(levelNumber);
      _game = updated;
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadInitialGame() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final current = await _repository.loadGame();
      _game = current;
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  StreamSubscription<GameEntity>? _gameSubscription;

  void listenToGame() {
    _gameSubscription ??= _repository.watchGame().listen((event) {
      _game = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _gameSubscription?.cancel();
    super.dispose();
  }
}
