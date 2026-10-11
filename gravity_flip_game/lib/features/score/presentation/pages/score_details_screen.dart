import 'package:flutter/material.dart';

import '../../domain/entities/score_entity.dart';

class ScoreDetailsScreen extends StatelessWidget {
  const ScoreDetailsScreen({super.key, required this.score});

  final ScoreEntity score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Score Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              score.playerName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _DetailRow(label: 'Score', value: score.score.toString()),
            _DetailRow(label: 'Level', value: score.levelName),
            _DetailRow(label: 'Rank', value: '#${score.rank}'),
            _DetailRow(
              label: 'Date',
              value: score.createdAt.toLocal().toString().split(' ').first,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
