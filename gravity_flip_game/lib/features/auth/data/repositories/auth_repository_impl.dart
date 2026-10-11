import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this._localDataSource});

  final AuthLocalDataSource _localDataSource;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Email and password are required.');
    }

    final session = await _localDataSource.getSession();
    final storedUser = session != null
        ? session['user'] as Map<String, dynamic>?
        : null;

    if (storedUser == null ||
        (storedUser['email'] as String? ?? '').toLowerCase() !=
            email.trim().toLowerCase()) {
      final fallbackUser = {
        'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
        'email': email.trim(),
        'username': email.split('@').first,
        'displayName': email.split('@').first,
        'avatarUrl': null,
        'bio': 'New player',
        'createdAt': DateTime.now().toIso8601String(),
        'lastLoginAt': DateTime.now().toIso8601String(),
      };

      final auth = AuthModel(
        token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresAt: DateTime.now().add(const Duration(days: 30)),
        user: fallbackUser,
      );

      await _localDataSource.saveSession(auth.toJson());

      return AuthResult(
        user: UserModel.fromJson(fallbackUser).toEntity(),
        token: auth.token,
        expiresAt: auth.expiresAt,
      );
    }

    final user = UserModel.fromJson(storedUser);
    final sessionToken =
        session?['token'] as String? ??
        'demo_token_${DateTime.now().millisecondsSinceEpoch}';
    final sessionExpiresAt =
        DateTime.tryParse(
          session?['expiresAt'] as String? ??
              DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        ) ??
        DateTime.now().add(const Duration(days: 30));

    final auth = AuthModel(
      token: sessionToken,
      expiresAt: sessionExpiresAt,
      user: storedUser,
    );

    await _localDataSource.saveSession(auth.toJson());

    return AuthResult(
      user: user.toEntity(),
      token: auth.token,
      expiresAt: auth.expiresAt,
    );
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String username,
    required String password,
    required String displayName,
  }) async {
    if (email.trim().isEmpty ||
        username.trim().isEmpty ||
        password.trim().length < 6) {
      throw Exception('Please provide valid registration details.');
    }

    final userData = {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email.trim(),
      'username': username.trim(),
      'displayName': displayName.trim().isEmpty
          ? username.trim()
          : displayName.trim(),
      'avatarUrl': null,
      'bio': 'New challenger',
      'createdAt': DateTime.now().toIso8601String(),
      'lastLoginAt': DateTime.now().toIso8601String(),
    };

    final auth = AuthModel(
      token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
      expiresAt: DateTime.now().add(const Duration(days: 30)),
      user: userData,
    );

    await _localDataSource.saveSession(auth.toJson());

    return AuthResult(
      user: UserModel.fromJson(userData).toEntity(),
      token: auth.token,
      expiresAt: auth.expiresAt,
    );
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearSession();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final session = await _localDataSource.getSession();
    if (session == null) return null;

    final userMap = session['user'] as Map<String, dynamic>?;
    if (userMap == null) return null;

    return UserModel.fromJson(userMap).toEntity();
  }
}
