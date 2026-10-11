import 'dart:async';

import '../../domain/entities/game_entity.dart';
import '../../domain/entities/level_entity.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/value_objects/game_state.dart';
import '../datasources/game_local_datasource.dart';
import '../datasources/game_remote_datasource.dart';
import '../mappers/game_mapper.dart';
import '../mappers/level_mapper.dart';

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl({
    required this._localDataSource,
    required GameRemoteDataSource remoteDataSource,
  }) : _gameController = StreamController<GameEntity>.broadcast() {
    _levelControllers = <int, StreamController<LevelEntity>>{};
  }

  final GameLocalDataSource _localDataSource;
  final StreamController<GameEntity> _gameController;
  late final Map<int, StreamController<LevelEntity>> _levelControllers;

  @override
  Future<GameEntity> loadGame() async {
    final model = await _localDataSource.loadGame();
    final entity = GameMapper.fromModel(model);
    _gameController.add(entity);
    return entity;
  }

  @override
  Future<LevelEntity> loadLevel(int levelNumber) async {
    final model = await _localDataSource.loadLevel(levelNumber);
    final entity = LevelMapper.fromModel(model);
    final controller = _levelControllers.putIfAbsent(
      levelNumber,
      () => StreamController<LevelEntity>.broadcast(),
    );
    controller.add(entity);
    return entity;
  }

  @override
  Future<List<LevelEntity>> getLevels() async {
    final levelModels = [
      await _localDataSource.loadLevel(1),
      await _localDataSource.loadLevel(2),
      await _localDataSource.loadLevel(3),
    ];

    final entities = levelModels.map(LevelMapper.fromModel).toList();
    for (final entity in entities) {
      final controller = _levelControllers.putIfAbsent(
        entity.number,
        () => StreamController<LevelEntity>.broadcast(),
      );
      controller.add(entity);
    }
    return entities;
  }

  @override
  Future<void> saveProgress(GameEntity game) async {
    final model = GameMapper.toModel(game);
    await _localDataSource.saveGame(model);
    _gameController.add(game);
  }

  @override
  Future<void> saveLevelState(LevelEntity level) async {
    final model = LevelMapper.toModel(level);
    await _localDataSource.saveLevel(model);
    final controller = _levelControllers[level.number];
    controller?.add(level);
  }

  @override
  Future<GameState> getCurrentState() async {
    return _localDataSource.getCurrentState();
  }

  @override
  Future<void> updateCurrentState(GameState state) async {
    await _localDataSource.saveCurrentState(state);
  }

  @override
  Stream<GameEntity> watchGame() => _gameController.stream;

  @override
  Stream<LevelEntity> watchLevel(int levelNumber) {
    final controller = _levelControllers.putIfAbsent(
      levelNumber,
      () => StreamController<LevelEntity>.broadcast(),
    );
    return controller.stream;
  }
}
