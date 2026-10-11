import 'package:flutter/material.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.icon,
    required this.title,
    required this.isUnlocked,
    this.progressRatio = 0.0,
  });

  final String icon;
  final String title;
  final bool isUnlocked;
  final double progressRatio;

  @override
  Widget build(BuildContext context) {
    final color = isUnlocked ? Colors.amber : Colors.grey.shade700;
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: isUnlocked
              ? [const Color(0xFFFFD54F), const Color(0xFFFFA000)]
              : [Colors.grey.shade800, Colors.grey.shade700],
        ),
        border: Border.all(color: color.withValues(alpha: 0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isUnlocked ? 0.35 : 0.14),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            if (!isUnlocked)
              Positioned(
                bottom: 8,
                child: SizedBox(
                  width: 42,
                  child: LinearProgressIndicator(
                    value: progressRatio.clamp(0.0, 1.0),
                    backgroundColor: Colors.black26,
                    color: Colors.amber,
                    minHeight: 5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
