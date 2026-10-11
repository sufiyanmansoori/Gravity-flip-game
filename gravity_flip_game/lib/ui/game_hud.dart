import 'package:flutter/material.dart';
import '../game/gravity_flip_game.dart';

class GameHud extends StatefulWidget {
  final GravityFlipGame game;
  const GameHud({super.key, required this.game});

  @override
  State<GameHud> createState() => _GameHudState();
}

class _GameHudState extends State<GameHud> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _scoreCard(),
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.game.isPaused) {
                    widget.game.resume();
                  } else {
                    widget.game.pause();
                  }
                });
              },
              icon: Icon(widget.game.isPaused ? Icons.play_arrow : Icons.pause),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0x44161A3C),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6C4BFF).withAlpha(153)),
      ),
      child: Row(
        children: [
          const Icon(Icons.score, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            '${widget.game.score}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
