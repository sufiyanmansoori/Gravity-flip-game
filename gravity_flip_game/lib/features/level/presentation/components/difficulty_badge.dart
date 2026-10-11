import 'package:flutter/material.dart';

import '../../domain/value_objects/level_difficulty.dart';

class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({super.key, required this.difficulty});

  final LevelDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: difficulty.color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: difficulty.color.withValues(alpha: 0.5)),
      ),
      child: Text(
        difficulty.label,
        style: TextStyle(
          color: difficulty.color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}
