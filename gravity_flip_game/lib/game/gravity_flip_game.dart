import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/obstacle.dart';
import 'components/platform.dart';
import 'components/player.dart';
import 'level_generator.dart';

typedef GameOverCallback = void Function(int score);

class GravityFlipGame extends FlameGame {
  final GameOverCallback? onGameOver;
  final List<PlatformEntity> platforms = [];
  final List<Obstacle> obstacles = [];
  final Random _random = Random();
  final LevelConfig levelConfig;

  late Player player;
  int score = 0;
  int bestScore = 0;
  bool isPaused = false;
  bool _gameEnded = false;
  double _spawnTimer = 0;
  double _distance = 0;
  double _worldSpeed = 180;

  GravityFlipGame({
    this.onGameOver,
    this.levelConfig = const LevelConfig(
      worldIndex: 1,
      levelNumber: 1,
      worldName: 'Gravity Valley',
      levelName: 'L01 • World 1',
      baseSpeed: 180,
      gravityStrength: 1450,
      spawnInterval: 1.15,
    ),
  }) {
    _worldSpeed = levelConfig.baseSpeed;
  }

  @override
  Color backgroundColor() => const Color(0xFF06111D);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    player = Player(position: Vector2(size.x * 0.18, size.y * 0.52));
    add(player);
    createInitialPlatforms();
  }

  void createInitialPlatforms() {
    final bottom = PlatformEntity(position: Vector2(30, size.y * 0.78), size: Vector2(size.x * 0.62, 22));
    final top = PlatformEntity(position: Vector2(90, size.y * 0.18), size: Vector2(size.x * 0.6, 22));
    addPlatform(bottom);
    addPlatform(top);
    addPlatform(PlatformEntity(position: Vector2(size.x * 0.68, size.y * 0.55), size: Vector2(120, 18)));
  }

  void addPlatform(PlatformEntity platform) {
    platforms.add(platform);
    add(platform);
  }

  @override
  void update(double dt) {
    if (isPaused || _gameEnded) return;
    super.update(dt);

    player.updateMotion(dt);
    _distance += _worldSpeed * dt;
    score = (_distance / 12).floor();

    for (final p in List<PlatformEntity>.from(platforms)) {
      p.position.x -= _worldSpeed * dt;
      if (p.position.x + p.size.x < -80) {
        remove(p);
        platforms.remove(p);
      }
    }

    for (final o in List<Obstacle>.from(obstacles)) {
      o.position.x -= _worldSpeed * dt;
      if (o.position.x + o.size.x < -80) {
        remove(o);
        obstacles.remove(o);
      }
    }

    _spawnTimer += dt;
    if (_spawnTimer > levelConfig.spawnInterval) {
      _spawnTimer = 0;
      spawnPlatform();
    }

    handleCollisions();

    if (player.position.y > size.y + 100 || player.position.y < -120) {
      endGame();
    }
  }

  void spawnPlatform() {
    final width = 120.0 + _random.nextDouble() * 100;
    final horizontalPadding = 50.0;
    final lastPlatformX = platforms.isEmpty ? size.x : platforms.last.position.x;
    final targetX = lastPlatformX + horizontalPadding + 80;
    final y = _random.nextDouble() * (size.y * 0.58) + 90;
    final platform = PlatformEntity(position: Vector2(targetX, y), size: Vector2(width, 18));
    addPlatform(platform);

    if (_random.nextDouble() < 0.60) {
      final obstacleX = platform.position.x + width * 0.5 - 12;
      final obstacle = Obstacle(position: Vector2(obstacleX, y - 28), size: Vector2(24, 24));
      obstacles.add(obstacle);
      add(obstacle);
    }
  }

  void handleCollisions() {
    final playerRect = player.rect;

    for (final platform in platforms) {
      if (!playerRect.overlaps(platform.rect)) continue;

      final previousBottom = player.previousY + player.size.y;
      final platformTop = platform.position.y;
      final platformBottom = platform.position.y + platform.size.y;

      if (player.velocity.y > 0 && previousBottom <= platformTop + 6) {
        player.position.y = platformTop - player.size.y;
        player.velocity.y = 0;
      } else if (player.velocity.y < 0 && player.previousY >= platformBottom - 6) {
        player.position.y = platformBottom;
        player.velocity.y = 0;
      }
    }

    for (final obstacle in obstacles) {
      if (playerRect.overlaps(obstacle.rect)) {
        endGame();
        break;
      }
    }
  }

  void flipGravity() {
    if (_gameEnded) return;
    player.flipGravity();
  }

  void pause() {
    isPaused = true;
  }

  void resume() {
    isPaused = false;
  }

  void endGame() {
    if (_gameEnded) return;
    _gameEnded = true;
    if (score > bestScore) {
      bestScore = score;
    }
    onGameOver?.call(score);
  }

  @override
  void onDispose() {
    // Hook for later audio cleanup if needed.
    super.onDispose();
  }
}
