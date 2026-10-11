import 'package:flutter/material.dart';

import '../../domain/entities/level_entity.dart';
import 'level_card.dart';

class LevelGrid extends StatelessWidget {
  const LevelGrid({
    super.key,
    required this.levels,
    required this.onLevelSelected,
  });

  final List<LevelEntity> levels;
  final ValueChanged<String> onLevelSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: levels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {
        final level = levels[index];
        return LevelCard(level: level, onTap: () => onLevelSelected(level.id));
      },
    );
  }
}
