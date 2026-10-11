import 'package:flutter/material.dart';

import '../../domain/entities/score_entity.dart';
import '../pages/score_details_screen.dart';
import 'score_card.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.scores});

  final List<ScoreEntity> scores;

  @override
  Widget build(BuildContext context) {
    if (scores.isEmpty) {
      return const Center(
        child: Text('No scores yet. Finish a level to set a mark.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: scores.length,
      itemBuilder: (context, index) {
        final score = scores[index];
        return ScoreCard(
          score: score,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ScoreDetailsScreen(score: score),
              ),
            );
          },
        );
      },
    );
  }
}
