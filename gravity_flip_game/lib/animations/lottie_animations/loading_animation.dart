import 'dart:math' as math;

import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({
    super.key,
    this.size = 80,
    this.color = const Color(0xFF6C4BFF),
  });

  final double size;
  final Color color;

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _LoadingPainter(
              progress: _controller.value,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

class _LoadingPainter extends CustomPainter {
  const _LoadingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.35;

    for (var index = 0; index < 12; index++) {
      final angle = (index / 12) * math.pi * 2 + progress * math.pi * 2;
      final x = center.dx + math.cos(angle) * radius;
      final y = center.dy + math.sin(angle) * radius;

      final rect = Rect.fromCircle(
        center: Offset(x, y),
        radius: size.width * 0.07,
      );
      final paint = Paint()
        ..color = color.withValues(alpha: 0.15 + (index / 12) * 0.85);
      canvas.drawOval(rect, paint);
    }

    final ring = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      progress * math.pi * 2,
      false,
      ring,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
