import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/achievement_local_datasource.dart';
import '../../data/repositories/achievement_repository_impl.dart';
import '../../domain/usecases/get_achievements_usecase.dart';
import '../../domain/usecases/unlock_achievement_usecase.dart';
import '../bloc/achievement_bloc.dart';
import '../components/achievement_card.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AchievementRepositoryImpl(
      localDataSource: AchievementLocalDataSource(),
    );

    return BlocProvider(
      create: (_) => AchievementBloc(
        getAchievementsUseCase: GetAchievementsUseCase(repository),
        unlockAchievementUseCase: UnlockAchievementUseCase(repository),
      )..add(const LoadAchievements()),
      child: const _AchievementsView(),
    );
  }
}

class _AchievementsView extends StatelessWidget {
  const _AchievementsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<AchievementBloc>().add(
              const RefreshAchievements(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AchievementBloc, AchievementState>(
        builder: (context, state) {
          if (state is AchievementLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AchievementFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            );
          }

          if (state is AchievementLoaded) {
            final achievements = state.achievements;

            if (achievements.isEmpty) {
              return const Center(
                child: Text('No achievements available yet.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return AchievementCard(
                  achievement: achievement,
                  onTap: () {
                    if (!achievement.isUnlocked &&
                        achievement.progress >= achievement.target) {
                      context.read<AchievementBloc>().add(
                        UnlockAchievement(achievement.id),
                      );
                    }
                  },
                );
              },
            );
          }

          if (state is AchievementUnlocked) {
            return BlocBuilder<AchievementBloc, AchievementState>(
              builder: (context, innerState) {
                if (innerState is AchievementLoaded) {
                  final achievements = innerState.achievements;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = achievements[index];
                      return AchievementCard(
                        achievement: achievement,
                        onTap: () {},
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          }

          return const Center(child: Text('Loading achievements...'));
        },
      ),
    );
  }
}
