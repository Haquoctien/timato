import 'package:flutter/material.dart';

class DrawnTriangle extends CustomPainter {
  late final Paint painter;
  final Color color;

  DrawnTriangle({
    required this.color,
  }) {
    painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width * 0.75, size.height);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
