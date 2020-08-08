import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class DrawerBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.light.withOpacity(0.1);

    canvas.drawCircle(Offset.zero, 220.0, paint);
    canvas.drawCircle(Offset.zero, 130.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
