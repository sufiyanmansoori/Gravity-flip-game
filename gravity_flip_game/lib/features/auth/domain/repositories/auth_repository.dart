import '../entities/user_entity.dart';

class AuthResult {
  const AuthResult({
    required this.user,
    required this.token,
    required this.expiresAt,
  });

  final UserEntity user;
  final String token;
  final DateTime expiresAt;
}

abstract class AuthRepository {
  Future<AuthResult> login({required String email, required String password});
  Future<AuthResult> register({
    required String email,
    required String username,
    required String password,
    required String displayName,
  });
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}
