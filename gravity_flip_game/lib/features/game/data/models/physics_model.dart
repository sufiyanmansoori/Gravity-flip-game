import 'package:equatable/equatable.dart';

class PhysicsModel extends Equatable {
  const PhysicsModel({
    required this.gravity,
    required this.jumpVelocity,
    required this.velocityY,
    required this.velocityX,
    required this.drag,
    required this.airResistance,
  });

  final double gravity;
  final double jumpVelocity;
  final double velocityY;
  final double velocityX;
  final double drag;
  final double airResistance;

  factory PhysicsModel.fromJson(Map<String, dynamic> json) {
    return PhysicsModel(
      gravity: (json['gravity'] as num?)?.toDouble() ?? 1800,
      jumpVelocity: (json['jumpVelocity'] as num?)?.toDouble() ?? -620,
      velocityY: (json['velocityY'] as num?)?.toDouble() ?? 0,
      velocityX: (json['velocityX'] as num?)?.toDouble() ?? 0,
      drag: (json['drag'] as num?)?.toDouble() ?? 0.0,
      airResistance: (json['airResistance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'gravity': gravity,
    'jumpVelocity': jumpVelocity,
    'velocityY': velocityY,
    'velocityX': velocityX,
    'drag': drag,
    'airResistance': airResistance,
  };

  PhysicsModel copyWith({
    double? gravity,
    double? jumpVelocity,
    double? velocityY,
    double? velocityX,
    double? drag,
    double? airResistance,
  }) {
    return PhysicsModel(
      gravity: gravity ?? this.gravity,
      jumpVelocity: jumpVelocity ?? this.jumpVelocity,
      velocityY: velocityY ?? this.velocityY,
      velocityX: velocityX ?? this.velocityX,
      drag: drag ?? this.drag,
      airResistance: airResistance ?? this.airResistance,
    );
  }

  @override
  List<Object?> get props => [
    gravity,
    jumpVelocity,
    velocityY,
    velocityX,
    drag,
    airResistance,
  ];
}
