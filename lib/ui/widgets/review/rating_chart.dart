import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';

class RatingChart extends StatelessWidget {
  final int total;
  final double average;
  final Map<int, int> stars;

  const RatingChart({
    super.key,
    required this.total,
    required this.stars,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 20.0, right: 24.0, top: 10.0),
      child: Row(
        children: [
          _buildDetails(context),
          const SizedBox(width: 16.0),
          Expanded(child: _buildBars(context)),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      children: [
        Text(
          average.toStringAsFixed(1),
          style: context.t.headline1,
        ),
        StarRatingBar(
          size: 12.0,
          rating: average,
        ),
        const SizedBox(height: 6.0),
        Text(
          '$total reviews',
          style: context.t.headline6,
        ),
      ],
    );
  }

  Widget _buildBars(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = stars.length; i > 0; --i)
          ScaleAnimator(
            child: _buildBar(context, i),
          ),
      ],
    );
  }

  Widget _buildBar(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Text(
            index.toString(),
            style: context.t.headline6?.bold,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, 6.0),
                  painter: BarPainter(
                    value: stars[index]! / total * constraints.maxWidth,
                    backgroundColor: context.c.surface,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;

  BarPainter({
    required this.value,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final hOffset = size.height / 2.0;

    final barPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, hOffset),
      Offset(width, hOffset),
      barPaint..color = backgroundColor,
    );

    if (value > 0.0) {
      canvas.drawLine(
        Offset(0, hOffset),
        Offset(value, hOffset),
        barPaint..color = AppColors.primary,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
