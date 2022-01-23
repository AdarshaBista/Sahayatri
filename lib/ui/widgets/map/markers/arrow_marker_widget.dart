import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class ArrowMarkerWidget extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double arrowWidth;
  final double arrowHeight;
  final VoidCallback onTap;

  const ArrowMarkerWidget({
    required this.child,
    this.color,
    this.onTap,
    this.arrowWidth = 30.0,
    this.arrowHeight = 20.0,
    this.borderRadius = 6.0,
    this.padding = EdgeInsets.zero,
  })  : assert(child != null),
        assert(padding != null),
        assert(arrowWidth != null),
        assert(arrowHeight != null),
        assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: ElevatedCard(
              child: child,
              color: color,
              padding: padding,
              radius: borderRadius,
            ),
          ),
          CustomPaint(
            size: Size(arrowWidth, arrowHeight),
            painter: _ArrowPainter(color: color ?? context.theme.cardColor),
          ),
        ],
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;

  const _ArrowPainter({
    required this.color,
  }) : assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint()..color = color;
    final path = Path()
      ..quadraticBezierTo(width / 2.0, height / 10.0, width / 2.0, height)
      ..quadraticBezierTo(width / 2.0, height / 10.0, width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}
