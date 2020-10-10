import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class RatingChart extends StatelessWidget {
  final int total;
  final double average;
  final Map<int, int> stars;

  const RatingChart({
    @required this.total,
    @required this.stars,
    @required this.average,
  })  : assert(total != null),
        assert(stars != null),
        assert(average != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 20.0, right: 24.0, top: 10.0),
      child: Row(
        children: [
          _buildDetails(),
          const SizedBox(width: 16.0),
          Expanded(child: _buildBars()),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return SlideAnimator(
      begin: const Offset(-0.4, 0.0),
      child: Column(
        children: [
          Text(
            average.toStringAsFixed(1),
            style: AppTextStyles.huge.darkAccent,
          ),
          StarRatingBar(
            size: 12.0,
            rating: average,
          ),
          const SizedBox(height: 6.0),
          Text(
            '$total reviews',
            style: AppTextStyles.extraSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBars() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = stars.length; i > 0; --i)
          SlideAnimator(
            begin: Offset(0.2 + (stars.length + 1 - i) * 0.1, 0.0),
            child: _buildBar(i),
          ),
      ],
    );
  }

  Widget _buildBar(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Text(
            index.toString(),
            style: AppTextStyles.extraSmall.bold,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, 6.0),
                  painter: BarPainter(stars[index] / total * constraints.maxWidth),
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

  BarPainter(this.value);

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
      barPaint..color = AppColors.lightAccent,
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
