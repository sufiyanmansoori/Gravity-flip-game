import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  const PlayerModel({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.velocityY,
    required this.isGrounded,
    required this.rotation,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final double velocityY;
  final bool isGrounded;
  final double rotation;

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 36,
      height: (json['height'] as num?)?.toDouble() ?? 36,
      velocityY: (json['velocityY'] as num?)?.toDouble() ?? 0,
      isGrounded: json['isGrounded'] as bool? ?? true,
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'width': width,
    'height': height,
    'velocityY': velocityY,
    'isGrounded': isGrounded,
    'rotation': rotation,
  };

  PlayerModel copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
    double? velocityY,
    bool? isGrounded,
    double? rotation,
  }) {
    return PlayerModel(
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      velocityY: velocityY ?? this.velocityY,
      isGrounded: isGrounded ?? this.isGrounded,
      rotation: rotation ?? this.rotation,
    );
  }

  @override
  List<Object?> get props => [
    x,
    y,
    width,
    height,
    velocityY,
    isGrounded,
    rotation,
  ];
}
