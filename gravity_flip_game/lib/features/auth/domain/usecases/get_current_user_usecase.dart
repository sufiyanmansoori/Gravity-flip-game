import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this.repository);

  final AuthRepository repository;

  Future<UserEntity?> call() => repository.getCurrentUser();
}
