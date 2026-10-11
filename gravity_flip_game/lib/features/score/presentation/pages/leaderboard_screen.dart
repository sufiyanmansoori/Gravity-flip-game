import 'package:flutter/material.dart';

import '../../data/datasources/score_local_datasource.dart';
import '../../data/datasources/score_remote_datasource.dart';
import '../../data/repositories/score_repository_impl.dart';
import '../../domain/entities/score_entity.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';
import '../components/leaderboard_list.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: const LeaderboardBody(),
    );
  }
}

class LeaderboardBody extends StatefulWidget {
  const LeaderboardBody({super.key});

  @override
  State<LeaderboardBody> createState() => _LeaderboardBodyState();
}

class _LeaderboardBodyState extends State<LeaderboardBody> {
  late final Future<List<ScoreEntity>> _future;

  @override
  void initState() {
    super.initState();
    final repository = ScoreRepositoryImpl(
      localDataSource: ScoreLocalDataSource(),
      remoteDataSource: ScoreRemoteDataSourceImpl(),
    );
    _future = GetLeaderboardUseCase(repository)();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScoreEntity>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load leaderboard: ${snapshot.error}'),
          );
        }
        final scores = snapshot.data ?? const <ScoreEntity>[];
        return LeaderboardList(scores: scores);
      },
    );
  }
}
