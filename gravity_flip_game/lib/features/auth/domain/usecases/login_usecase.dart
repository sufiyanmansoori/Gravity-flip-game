import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthResult> call({required String email, required String password}) =>
      repository.login(email: email, password: password);
}
