import 'package:equatable/equatable.dart';

import '../../domain/entities/achievement_entity.dart';

class AchievementModel extends Equatable {
  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.progress,
    required this.target,
    required this.isUnlocked,
    this.unlockedAt,
    required this.rarity,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final int progress;
  final int target;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final String rarity;
  final DateTime createdAt;

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id:
          json['id'] as String? ??
          'achievement_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Achievement',
      description: json['description'] as String? ?? 'Complete the challenge.',
      icon: json['icon'] as String? ?? '🏆',
      category: json['category'] as String? ?? 'general',
      progress: json['progress'] as int? ?? 0,
      target: json['target'] as int? ?? 1,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.tryParse(json['unlockedAt'] as String) ?? DateTime.now()
          : null,
      rarity: json['rarity'] as String? ?? 'common',
      createdAt:
          DateTime.tryParse(
            json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'category': category,
      'progress': progress,
      'target': target,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'rarity': rarity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  AchievementEntity toEntity() {
    return AchievementEntity(
      id: id,
      title: title,
      description: description,
      icon: icon,
      category: category,
      progress: progress,
      target: target,
      isUnlocked: isUnlocked,
      unlockedAt: unlockedAt,
      rarity: rarity,
      createdAt: createdAt,
    );
  }

  factory AchievementModel.fromEntity(AchievementEntity entity) {
    return AchievementModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      icon: entity.icon,
      category: entity.category,
      progress: entity.progress,
      target: entity.target,
      isUnlocked: entity.isUnlocked,
      unlockedAt: entity.unlockedAt,
      rarity: entity.rarity,
      createdAt: entity.createdAt,
    );
  }

  AchievementModel copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? category,
    int? progress,
    int? target,
    bool? isUnlocked,
    DateTime? unlockedAt,
    String? rarity,
    DateTime? createdAt,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rarity: rarity ?? this.rarity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    icon,
    category,
    progress,
    target,
    isUnlocked,
    unlockedAt,
    rarity,
    createdAt,
  ];
}
