import 'package:flutter/material.dart';

class AchievementItem {
  final String title;
  final String description;
  final int current;
  final int target;
  final bool unlocked;
  final IconData icon;

  const AchievementItem({
    required this.title,
    required this.description,
    required this.current,
    required this.target,
    required this.unlocked,
    required this.icon,
  });
}

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      const AchievementItem(
        title: 'First Flip',
        description: 'Perform your first gravity flip.',
        current: 1,
        target: 1,
        unlocked: true,
        icon: Icons.touch_app_rounded,
      ),
      const AchievementItem(
        title: '100 Points',
        description: 'Reach 100 score in a single run.',
        current: 72,
        target: 100,
        unlocked: false,
        icon: Icons.score_rounded,
      ),
      const AchievementItem(
        title: '500 Points',
        description: 'Reach 500 score in a single run.',
        current: 350,
        target: 500,
        unlocked: false,
        icon: Icons.rocket_launch_rounded,
      ),
      const AchievementItem(
        title: 'Gravity Master',
        description: 'Survive 20 flips in one run.',
        current: 11,
        target: 20,
        unlocked: false,
        icon: Icons.auto_awesome_rounded,
      ),
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF090D18), Color(0xFF141C2B)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'ACHIEVEMENTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: achievements.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = achievements[index];
                      final progress = (item.current / item.target).clamp(0.0, 1.0);

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0x22161A3C),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: item.unlocked ? const Color(0xFF00D2FF) : const Color(0xFF6C4BFF).withAlpha(120),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: item.unlocked ? const Color(0xFF00D2FF) : const Color(0xFF6C4BFF).withAlpha(100),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(item.icon, color: Colors.white),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 8,
                                    backgroundColor: Colors.white10,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00D2FF)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.current}/${item.target}',
                                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
