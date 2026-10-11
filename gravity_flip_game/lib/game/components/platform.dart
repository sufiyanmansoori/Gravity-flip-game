import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlatformEntity extends PositionComponent {
  PlatformEntity({required Vector2 position, required Vector2 size}) : super(position: position, size: size, anchor: Anchor.topLeft) {
    paint = Paint()..color = const Color(0xFF1E293B);
  }

  late Paint paint;

  Rect get rect => toRect();

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(toRect(), const Radius.circular(10));
    final fill = Paint()..shader = const LinearGradient(colors: [Color(0xFF172032), Color(0xFF00121E)]).createShader(toRect());
    final edge = Paint()..color = const Color(0xFF6C4BFF).withAlpha(217);
    canvas.drawRRect(rrect, fill);
    // neon edge
    final edgeRect = toRect().deflate(2);
    edge.strokeWidth = 2;
    edge.style = PaintingStyle.stroke;
    canvas.drawRRect(RRect.fromRectAndRadius(edgeRect, const Radius.circular(10)), edge);
  }
}
