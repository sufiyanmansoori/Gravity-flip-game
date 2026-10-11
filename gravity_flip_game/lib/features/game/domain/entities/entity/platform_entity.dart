import 'package:equatable/equatable.dart';

class PlatformEntity extends Equatable {
  const PlatformEntity({
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

  PlatformEntity copyWith({
    String? id,
    double? x,
    double? y,
    double? width,
    double? height,
    bool? isSolid,
  }) {
    return PlatformEntity(
      id: id ?? this.id,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      isSolid: isSolid ?? this.isSolid,
    );
  }

  @override
  List<Object?> get props => [id, x, y, width, height, isSolid];
}
