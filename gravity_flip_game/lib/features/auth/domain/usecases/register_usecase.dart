import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthResult> call({
    required String email,
    required String username,
    required String password,
    required String displayName,
  }) => repository.register(
    email: email,
    username: username,
    password: password,
    displayName: displayName,
  );
}
