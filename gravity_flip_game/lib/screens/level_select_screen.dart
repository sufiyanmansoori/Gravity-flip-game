import 'package:flutter/material.dart';

import '../game/level_generator.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final worlds = LevelGenerator.generateWorlds();

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF07111D), Color(0xFF0F1830)],
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
                    const SizedBox(width: 8),
                    const Text(
                      'WORLD MAP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    itemCount: worlds.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final world = worlds[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1A1836).withAlpha(210),
                              const Color(0xFF132B42).withAlpha(210),
                            ],
                          ),
                          border: Border.all(color: const Color(0xFF6C4BFF).withAlpha(200)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              world.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              world.subtitle,
                              style: const TextStyle(color: Colors.white60),
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                world.totalLevels,
                                (levelIndex) {
                                  final levelNumber = levelIndex + 1;
                                  final unlocked = levelNumber <= 6 || index == 0;
                                  return GestureDetector(
                                    onTap: unlocked
                                        ? () {
                                            Navigator.of(context).pop();
                                          }
                                        : null,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 220),
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: unlocked
                                            ? const Color(0xFF6C4BFF)
                                            : Colors.white10,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: unlocked
                                              ? const Color(0xFF00D2FF)
                                              : Colors.white24,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$levelNumber',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
