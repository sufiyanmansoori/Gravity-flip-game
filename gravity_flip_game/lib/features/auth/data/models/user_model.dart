import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:
          json['id'] as String? ??
          'user_${DateTime.now().millisecondsSinceEpoch}',
      email: json['email'] as String? ?? '',
      username: json['username'] as String? ?? 'player',
      displayName: json['displayName'] as String? ?? 'Player',
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String? ?? '',
      createdAt:
          DateTime.tryParse(
            json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.tryParse(json['lastLoginAt'] as String) ?? DateTime.now()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      bio: bio,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      displayName: entity.displayName,
      avatarUrl: entity.avatarUrl,
      bio: entity.bio,
      createdAt: entity.createdAt,
      lastLoginAt: entity.lastLoginAt,
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
