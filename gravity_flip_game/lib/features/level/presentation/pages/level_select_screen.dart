import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/level_local_datasource.dart';
import '../../data/datasources/level_remote_datasource.dart';
import '../../data/repositories/level_repository_impl.dart';
import '../../domain/usecases/get_all_levels_usecase.dart';
import '../../domain/usecases/get_level_usecase.dart';
import '../../domain/usecases/unlock_level_usecase.dart';
import '../../domain/value_objects/level_difficulty.dart';
import '../bloc/level_bloc.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = LevelRepositoryImpl(
      localDataSource: LevelLocalDataSourceImpl(),
      remoteDataSource: LevelRemoteDataSourceImpl(),
    );

    return BlocProvider(
      create: (_) => LevelBloc(
        getAllLevelsUseCase: GetAllLevelsUseCase(repository),
        getLevelUseCase: GetLevelUseCase(repository),
        unlockLevelUseCase: UnlockLevelUseCase(repository),
      )..add(const LoadLevels()),
      child: const _LevelSelectView(),
    );
  }
}

class _LevelSelectView extends StatelessWidget {
  const _LevelSelectView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Level')),
      body: BlocBuilder<LevelBloc, LevelState>(
        builder: (context, state) {
          if (state is LevelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LevelFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 42),
                  const SizedBox(height: 12),
                  Text(state.message),
                ],
              ),
            );
          }

          if (state is LevelLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: state.levels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final level = state.levels[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: level.isUnlocked
                        ? () {
                            context.read<LevelBloc>().add(
                              SelectLevel(level.id),
                            );
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: level.isUnlocked
                            ? LinearGradient(
                                colors: [
                                  level.difficulty.color,
                                  level.difficulty.color.withValues(alpha: 0.7),
                                ],
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey.shade800,
                                  Colors.grey.shade700,
                                ],
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level ${level.number}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  level.difficulty.label,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            level.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            level.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: List.generate(
                              3,
                              (starIndex) => Icon(
                                starIndex < level.stars
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const Center(child: Text('No levels available'));
        },
      ),
    );
  }
}
