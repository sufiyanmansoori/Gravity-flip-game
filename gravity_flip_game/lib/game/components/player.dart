import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  Vector2 velocity = Vector2.zero();
  double gravity = 1450.0;
  double maxSpeed = 980.0;
  bool gravityDown = true;
  bool onGround = false;
  double previousY = 0;

  Player({required Vector2 position})
      : super(position: position, size: Vector2(36, 36), anchor: Anchor.topLeft) {
    paint = BasicPalette.white.paint()..color = Colors.cyanAccent;
  }

  late Paint paint;
  Rect get rect => toRect();

  void updateMotion(double dt) {
    previousY = position.y;
    final g = gravityDown ? gravity : -gravity;
    velocity.y += g * dt;
    if (velocity.y.abs() > maxSpeed) {
      velocity.y = velocity.y.sign * maxSpeed;
    }
    position += velocity * dt;
    angle = (velocity.y / maxSpeed) * 0.5;
  }

  void flipGravity() {
    gravityDown = !gravityDown;
    velocity.y = -velocity.y * 0.55;
    velocity.y += gravityDown ? 80.0 : -80.0;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x / 2;
    final center = Offset(position.x + r, position.y + r);
    final outer = Paint()..color = const Color(0xFF6C4BFF).withAlpha(150);
    final inner = Paint()
      ..color = gravityDown ? const Color(0xFF00E4FF) : const Color(0xFFFF6EC7);
    canvas.drawCircle(center, r + 6, outer);
    canvas.drawCircle(center, r, inner);

    final eye = Paint()..color = const Color.fromRGBO(255, 255, 255, 0.9);
    canvas.drawCircle(center.translate(0, -3), 4, eye);
  }
}
