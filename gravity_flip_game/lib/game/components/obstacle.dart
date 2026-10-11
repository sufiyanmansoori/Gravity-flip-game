import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Obstacle extends PositionComponent {
  Obstacle({required Vector2 position, required Vector2 size}) : super(position: position, size: size, anchor: Anchor.topLeft) {
    paint = Paint()..color = const Color(0xFFFF4D6D);
  }

  late Paint paint;
  Rect get rect => toRect();

  @override
  void render(Canvas canvas) {
    final r = toRect();
    final path = Path();
    path.moveTo(r.left, r.bottom);
    path.lineTo(r.left + r.width*0.5, r.top);
    path.lineTo(r.right, r.bottom);
    path.close();
    final fill = Paint()..shader = const LinearGradient(colors: [Color(0xFFFF6A88), Color(0xFFFF4D6D)]).createShader(r);
    canvas.drawPath(path, fill);
    // glow outline
    final outline = Paint()..color = const Color(0xFFFF4D6D).withAlpha(230)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(path, outline);
  }
}
