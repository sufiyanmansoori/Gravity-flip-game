import 'package:equatable/equatable.dart';

class ObstacleModel extends Equatable {
  const ObstacleModel({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.isPassed,
    required this.kind,
  });

  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  final bool isPassed;
  final String kind;

  factory ObstacleModel.fromJson(Map<String, dynamic> json) {
    return ObstacleModel(
      id:
          json['id'] as String? ??
          'obstacle_${DateTime.now().millisecondsSinceEpoch}',
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 50,
      height: (json['height'] as num?)?.toDouble() ?? 80,
      isPassed: json['isPassed'] as bool? ?? false,
      kind: json['kind'] as String? ?? 'barrier',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'x': x,
    'y': y,
    'width': width,
    'height': height,
    'isPassed': isPassed,
    'kind': kind,
  };

  @override
  List<Object?> get props => [id, x, y, width, height, isPassed, kind];
}
