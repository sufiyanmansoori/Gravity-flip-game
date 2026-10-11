import 'package:equatable/equatable.dart';

class PlatformModel extends Equatable {
  const PlatformModel({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.isSolid,
  });

  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  final bool isSolid;

  factory PlatformModel.fromJson(Map<String, dynamic> json) {
    return PlatformModel(
      id:
          json['id'] as String? ??
          'platform_${DateTime.now().millisecondsSinceEpoch}',
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 100,
      height: (json['height'] as num?)?.toDouble() ?? 20,
      isSolid: json['isSolid'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'x': x,
    'y': y,
    'width': width,
    'height': height,
    'isSolid': isSolid,
  };

  @override
  List<Object?> get props => [id, x, y, width, height, isSolid];
}
