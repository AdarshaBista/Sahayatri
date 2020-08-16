import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge_review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class LodgeReviewCard extends StatelessWidget {
  final LodgeReview review;

  const LodgeReviewCard({
    @required this.review,
  }) : assert(review != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: CustomCard(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(review.user.imageUrl),
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
