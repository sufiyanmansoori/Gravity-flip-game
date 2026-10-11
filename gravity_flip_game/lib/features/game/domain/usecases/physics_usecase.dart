import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';

class PhysicsUseCase {
  const PhysicsUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call({
    required double delta,
    required double playerY,
    required double playerX,
    required double targetHeight,
  }) async {
    final game = await repository.loadGame();
    final physics = game.physics;

    final newVelocityY = physics.velocityY + physics.gravity * delta;
    final newY = playerY + newVelocityY * delta;
    final clampedY = newY.clamp(0.0, targetHeight.toDouble());

    final updatedPhysics = physics.copyWith(
      velocityY: newVelocityY,
      velocityX: playerX,
    );

    final updated = game.copyWith(
      physics: updatedPhysics,
      playerPosition: (x: playerX, y: clampedY),
    );

    await repository.saveProgress(updated);
    return updated;
  }
}
