import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

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
    return SlideAnimator(
      begin: const Offset(0.4, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = stars.length; i > 0; --i) _buildBar(i),
        ],
      ),
    );
  }

  Widget _buildBar(int index) {
    return Row(
      children: [
        Text(
          index.toString(),
          style: AppTextStyles.extraSmall.bold,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Stack(
            children: [
              _buildContainer(AppColors.lightAccent),
              _buildContainer(AppColors.primary, stars[index] / total),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(Color color, [double percent = 1.0]) {
    return SizedBox(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: 8.0,
            width: percent * constraints.maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        },
      ),
    );
  }
}
