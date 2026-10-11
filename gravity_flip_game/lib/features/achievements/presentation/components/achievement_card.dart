import 'package:flutter/material.dart';

import '../../domain/entities/achievement_entity.dart';
import 'achievement_badge.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    super.key,
    required this.achievement,
    required this.onTap,
  });

  final AchievementEntity achievement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = achievement.progressRatio;
    final isUnlocked = achievement.isUnlocked || achievement.isCompleted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isUnlocked
                ? [const Color(0xFF1F2937), const Color(0xFF27374D)]
                : [const Color(0xFF111827), const Color(0xFF1F2937)],
          ),
          border: Border.all(
            color: isUnlocked
                ? Colors.amber.withValues(alpha: 0.7)
                : Colors.white10,
            width: isUnlocked ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AchievementBadge(
              icon: achievement.icon,
              title: achievement.title,
              isUnlocked: isUnlocked,
              progressRatio: progress,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          achievement.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? Colors.amber.withValues(alpha: 0.18)
                              : Colors.grey.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          isUnlocked ? 'Unlocked' : achievement.rarity,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isUnlocked ? Colors.amber : Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    achievement.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          backgroundColor: Colors.white10,
                          color: isUnlocked ? Colors.amber : Colors.cyanAccent,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${achievement.progress}/${achievement.target}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
