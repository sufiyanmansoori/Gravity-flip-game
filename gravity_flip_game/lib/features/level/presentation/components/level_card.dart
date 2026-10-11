import 'package:flutter/material.dart';

import '../../domain/entities/level_entity.dart';
import '../../domain/value_objects/level_difficulty.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({super.key, required this.level, required this.onTap});

  final LevelEntity level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLocked = !level.isUnlocked;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: isLocked ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isLocked
              ? const LinearGradient(
                  colors: [Color(0xFF374151), Color(0xFF1F2937)],
                )
              : LinearGradient(
                  colors: [
                    level.difficulty.color,
                    level.difficulty.color.withValues(alpha: 0.7),
                  ],
                ),
          boxShadow: [
            BoxShadow(
              color: (isLocked ? Colors.black : level.difficulty.color)
                  .withValues(alpha: 0.2),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'L${level.number}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  isLocked
                      ? Icons.lock_outline_rounded
                      : Icons.play_arrow_rounded,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              level.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                level.difficulty.label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: List.generate(
                3,
                (index) => Icon(
                  index < level.stars
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
