import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CurveBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final paint = Paint()
      ..color = AppColors.dark
      ..style = PaintingStyle.fill;

    final bottomCurve = Path()
      ..moveTo(0.0, height * 0.7)
      ..quadraticBezierTo(width * 0.25, height * 0.65, width * 0.5, height * 0.7)
      ..quadraticBezierTo(width * 0.75, height * 0.75, width * 1.0, height * 0.7)
      ..lineTo(width, height)
      ..lineTo(0.0, height);

    canvas.drawPath(bottomCurve, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
