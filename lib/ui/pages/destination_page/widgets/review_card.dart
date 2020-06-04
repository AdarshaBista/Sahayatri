import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
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
      child: CustomCard(
        elevation: 0.0,
        color: AppColors.light,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(review.user.imageUrl),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.user.name,
                  style: AppTextStyles.medium,
                ),
                const SizedBox(height: 4.0),
                StarRatingBar(
                  rating: review.rating,
                  size: 16.0,
                ),
                const Divider(height: 8.0),
              ],
            ),
            subtitle: Text(
              review.text,
              style: AppTextStyles.small,
            ),
          ),
        ),
      ),
    );
  }
}
