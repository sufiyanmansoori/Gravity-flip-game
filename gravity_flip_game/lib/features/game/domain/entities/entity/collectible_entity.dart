import 'package:equatable/equatable.dart';

class CollectibleEntity extends Equatable {
  const CollectibleEntity({
    required this.id,
    required this.x,
    required this.y,
    required this.radius,
    required this.value,
    this.isCollected = false,
  });

  final String id;
  final double x;
  final double y;
  final double radius;
  final int value;
  final bool isCollected;

  CollectibleEntity copyWith({
    String? id,
    double? x,
    double? y,
    double? radius,
    int? value,
    bool? isCollected,
  }) {
    return CollectibleEntity(
      id: id ?? this.id,
      x: x ?? this.x,
      y: y ?? this.y,
      radius: radius ?? this.radius,
      value: value ?? this.value,
      isCollected: isCollected ?? this.isCollected,
    );
  }

  @override
  List<Object?> get props => [id, x, y, radius, value, isCollected];
}
