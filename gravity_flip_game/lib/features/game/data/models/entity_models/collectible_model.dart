import 'package:equatable/equatable.dart';

class CollectibleModel extends Equatable {
  const CollectibleModel({
    required this.id,
    required this.x,
    required this.y,
    required this.radius,
    required this.value,
    required this.collected,
  });

  final String id;
  final double x;
  final double y;
  final double radius;
  final int value;
  final bool collected;

  factory CollectibleModel.fromJson(Map<String, dynamic> json) {
    return CollectibleModel(
      id:
          json['id'] as String? ??
          'collectible_${DateTime.now().millisecondsSinceEpoch}',
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      radius: (json['radius'] as num?)?.toDouble() ?? 12,
      value: json['value'] as int? ?? 10,
      collected: json['collected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'x': x,
    'y': y,
    'radius': radius,
    'value': value,
    'collected': collected,
  };

  @override
  List<Object?> get props => [id, x, y, radius, value, collected];
}
