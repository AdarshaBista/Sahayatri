import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ENGLISH', style: AppTextStyles.small.bold),
            const SizedBox(width: 16.0),
            const Icon(
              Icons.arrow_right_alt,
              color: AppColors.primaryDark,
            ),
            const SizedBox(width: 16.0),
            Text('NEPALI', style: AppTextStyles.small.bold),
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    const color = AppColors.light;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final top = height * 0.25;
    final bottom = height;

    final leftStart = width * 0.1;
    final leftEnd = leftStart + 32.0;
    final leftCtrlTop = leftStart + 16.0;
    final leftCtrlBottom = leftEnd - 16.0;

    final rightEnd = width * 0.9;
    final rightStart = rightEnd - 32.0;
    final rightCtrlTop = rightEnd - 16.0;
    final rightCtrlBottom = rightStart + 16.0;

    final curve = Path()
      ..lineTo(0.0, top)
      ..lineTo(leftStart, top)
      ..cubicTo(leftCtrlTop, top, leftCtrlBottom, bottom, leftEnd, bottom)
      ..lineTo(rightStart, bottom)
      ..cubicTo(rightCtrlBottom, bottom, rightCtrlTop, top, rightEnd, top)
      ..lineTo(width, top)
      ..lineTo(width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawShadow(curve, AppColors.dark.withOpacity(0.3), 3.0, false);
    canvas.drawPath(curve, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
