import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class IconMarkerWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  const IconMarkerWidget({
    @required this.icon,
    this.onTap,
    this.color = AppColors.dark,
    this.backgroundColor = AppColors.light,
  })  : assert(icon != null),
        assert(color != null),
        assert(backgroundColor != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _MarkerPainter(color: backgroundColor),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Icon(
              icon,
              size: 20.0,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkerPainter extends CustomPainter {
  final Color color;

  const _MarkerPainter({
    @required this.color,
  }) : assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0.0, height * 0.4)
      ..cubicTo(0.0, 0.0, width, 0.0, width, height * 0.4)
      ..cubicTo(width, height * 0.6, width * 0.5, height * 0.7, width * 0.5, height)
      ..cubicTo(width * 0.5, height * 0.7, 0.0, height * 0.6, 0.0, height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MarkerPainter oldDelegate) => false;
}
