import 'package:flutter/material.dart';

class DotPainter extends CustomPainter {
  final double spacing, dotRadius;
  final Color color;
  DotPainter({
    required this.spacing,
    required this.dotRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double y = spacing; y < size.height; y += spacing) {
      for (double x = spacing; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) {
    if (old is! DotPainter) return true;
    return old.spacing != spacing ||
        old.dotRadius != dotRadius ||
        old.color != color;
  }
}
