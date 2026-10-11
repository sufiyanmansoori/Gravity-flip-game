import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/gravity_flip_game.dart';
import '../game/level_generator.dart';
import '../ui/game_hud.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  final int worldIndex;
  final int levelNumber;

  const GameScreen({super.key, this.worldIndex = 1, this.levelNumber = 1});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  late final GravityFlipGame _game;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final config = LevelGenerator.generateLevel(widget.worldIndex, widget.levelNumber);
    _game = GravityFlipGame(
      levelConfig: config,
      onGameOver: _onGameOver,
    );
  }

  void _onGameOver(int finalScore) {
    if (!mounted) return;
    final best = _game.bestScore;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => GameOverScreen(score: finalScore, bestScore: best),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _game.onDispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _game.pause();
    } else if (state == AppLifecycleState.resumed) {
      _game.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          HapticFeedback.mediumImpact();
          _game.flipGravity();
        },
        child: GameWidget(
          game: _game,
          overlayBuilderMap: {
            'hud': (ctx, game) => GameHud(game: _game),
          },
          initialActiveOverlays: const ['hud'],
        ),
      ),
    );
  }
}
