import 'package:equatable/equatable.dart';

class AchievementEntity extends Equatable {
  const AchievementEntity({
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

  double get progressRatio =>
      target <= 0 ? 0 : (progress / target).clamp(0.0, 1.0);

  bool get isCompleted => progress >= target;

  AchievementEntity copyWith({
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
    return AchievementEntity(
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
