import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class RatingChart extends StatelessWidget {
  final List<double> ratings;

  const RatingChart({
    @required this.ratings,
  }) : assert(ratings != null);

  int get total => ratings.length;
  double get average => ratings.reduce((a, b) => a + b) / total;

  int get rating5 => ratings.where((r) => r >= 5.0).length;
  int get rating4 => ratings.where((r) => r >= 4.0 && r < 5.0).length;
  int get rating3 => ratings.where((r) => r >= 3.0 && r < 4.0).length;
  int get rating2 => ratings.where((r) => r >= 2.0 && r < 3.0).length;
  int get rating1 => ratings.where((r) => r >= 0.0 && r < 2.0).length;

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
      begin: const Offset(-1.0, 0.0),
      child: Column(
        children: [
          Text(
            average.toStringAsFixed(1),
            style: AppTextStyles.huge.darkAccent,
          ),
          StarRatingBar(
            rating: average,
            size: 12.0,
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
      begin: const Offset(1.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBar(5, rating5),
          _buildBar(4, rating4),
          _buildBar(3, rating3),
          _buildBar(2, rating2),
          _buildBar(1, rating1),
        ],
      ),
    );
  }

  Widget _buildBar(int label, int value) {
    return Row(
      children: [
        Text(
          label.toString(),
          style: AppTextStyles.extraSmall.bold,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Stack(
            children: [
              _buildContainer(AppColors.lightAccent),
              _buildContainer(AppColors.primary, value / total),
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
