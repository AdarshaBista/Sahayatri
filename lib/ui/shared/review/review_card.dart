import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    @required this.review,
  }) : assert(review != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: _buildUserAvatar(),
          title: Text(
            review.user.name,
            style: AppTextStyles.small.bold,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              StarRatingBar(
                rating: review.rating,
                size: 15.0,
              ),
              const SizedBox(height: 6.0),
              Text(
                review.text,
                style: AppTextStyles.small,
              ),
            ],
          ),
          trailing: Text(
            review.rating.toStringAsFixed(1),
            style: AppTextStyles.medium.bold.withColor(AppColors.barrier),
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return review.user.imageUrl != null
        ? CircleAvatar(backgroundImage: NetworkImage(review.user.imageUrl))
        : CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.4),
            child: Text(
              review.user.name[0],
              style: AppTextStyles.medium.withColor(AppColors.primaryDark),
            ),
          );
  }
}
