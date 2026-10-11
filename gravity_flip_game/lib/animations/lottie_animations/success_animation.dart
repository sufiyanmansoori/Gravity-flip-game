import 'package:flutter/material.dart';

class SuccessAnimation extends StatelessWidget {
  const SuccessAnimation({
    super.key,
    this.size = 120,
    this.color = const Color(0xFF35D399),
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _SuccessPainter(color)),
    );
  }
}

class _SuccessPainter extends CustomPainter {
  const _SuccessPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final start = Offset(size.width * 0.22, size.height * 0.52);
    final mid = Offset(size.width * 0.45, size.height * 0.72);
    final end = Offset(size.width * 0.8, size.height * 0.24);

    path.moveTo(start.dx, start.dy);
    path.lineTo(mid.dx, mid.dy);
    path.lineTo(end.dx, end.dy);

    canvas.drawPath(path, paint);

    final circlePaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final circleRadius = size.width * 0.42;
    final circle = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: circleRadius,
    );

    canvas.drawCircle(circle.center, circleRadius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
