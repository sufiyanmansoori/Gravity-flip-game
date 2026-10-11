class PhysicsProperties {
  const PhysicsProperties({
    required this.gravity,
    required this.jumpVelocity,
    required this.velocityX,
    required this.velocityY,
    required this.drag,
    required this.airResistance,
  });

  final double gravity;
  final double jumpVelocity;
  final double velocityX;
  final double velocityY;
  final double drag;
  final double airResistance;

  PhysicsProperties copyWith({
    double? gravity,
    double? jumpVelocity,
    double? velocityX,
    double? velocityY,
    double? drag,
    double? airResistance,
  }) {
    return PhysicsProperties(
      gravity: gravity ?? this.gravity,
      jumpVelocity: jumpVelocity ?? this.jumpVelocity,
      velocityX: velocityX ?? this.velocityX,
      velocityY: velocityY ?? this.velocityY,
      drag: drag ?? this.drag,
      airResistance: airResistance ?? this.airResistance,
    );
  }
}
