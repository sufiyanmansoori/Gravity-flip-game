import 'package:gravity_flip_game/features/auth/domain/entities/user_entity.dart';

class UserFixtures {
  const UserFixtures._();

  static final UserEntity activeUser = UserEntity(
    id: 'user_001',
    email: 'player@example.com',
    username: 'player_one',
    displayName: 'Player One',
    avatarUrl: 'https://example.com/avatar.png',
    bio: 'Gravity enthusiast',
    createdAt: DateTime.utc(2024),
    lastLoginAt: DateTime.utc(2024, 1, 2),
  );

  static Map<String, dynamic> activeUserJson() => {
    'id': activeUser.id,
    'email': activeUser.email,
    'username': activeUser.username,
    'displayName': activeUser.displayName,
    'avatarUrl': activeUser.avatarUrl,
    'bio': activeUser.bio,
    'createdAt': activeUser.createdAt.toIso8601String(),
    'lastLoginAt': activeUser.lastLoginAt?.toIso8601String(),
  };
}
