import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CurveBackground extends CustomPainter {
  const CurveBackground();

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final paint = Paint()
      ..color = AppColors.dark
      ..style = PaintingStyle.fill;

    final bottomCurve = Path()
      ..moveTo(0.0, -32.0)
      ..quadraticBezierTo(width * 0.25, -64.0, width * 0.5, -32.0)
      ..quadraticBezierTo(width * 0.75, 0.0, width * 1.0, -32.0)
      ..lineTo(width, height)
      ..lineTo(0.0, height);

    canvas.drawPath(bottomCurve, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
