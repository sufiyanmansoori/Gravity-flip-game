import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.bio = '',
    required this.createdAt,
    this.lastLoginAt,
  });

  final String id;
  final String email;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String bio;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  UserEntity copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? bio,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    displayName,
    avatarUrl,
    bio,
    createdAt,
    lastLoginAt,
  ];
}
