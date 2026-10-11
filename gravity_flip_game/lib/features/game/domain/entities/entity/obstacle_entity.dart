import 'package:equatable/equatable.dart';

class ObstacleEntity extends Equatable {
  const ObstacleEntity({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.kind,
    this.isPassed = false,
  });

  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  final String kind;
  final bool isPassed;

  ObstacleEntity copyWith({
    String? id,
    double? x,
    double? y,
    double? width,
    double? height,
    String? kind,
    bool? isPassed,
  }) {
    return ObstacleEntity(
      id: id ?? this.id,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      kind: kind ?? this.kind,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  @override
  List<Object?> get props => [id, x, y, width, height, kind, isPassed];
}
