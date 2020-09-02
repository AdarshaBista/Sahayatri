import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class ReviewCard extends StatefulWidget {
  final Review review;

  const ReviewCard({
    @required this.review,
  }) : assert(review != null);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isExpanded = false;

  void _expandText() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: GestureDetector(
        onTap: _expandText,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _buildUserAvatar(),
                  _buildTitle(),
                  const Spacer(),
                  _buildRating(),
                ],
              ),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            widget.review.user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.small.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        StarRatingBar(
          rating: widget.review.rating,
          size: 15.0,
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.review.rating.toStringAsFixed(1),
          style: AppTextStyles.medium.bold.withColor(AppColors.barrier),
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.review.date,
          style: AppTextStyles.extraSmall,
        ),
        const SizedBox(height: 6.0),
      ],
    );
  }

  Widget _buildText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        widget.review.text,
        style: AppTextStyles.small,
        overflow: TextOverflow.ellipsis,
        maxLines: isExpanded ? 100 : 2,
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 72.0,
      height: 72.0,
      child: ElevatedCard(
        borderRadius: 8.0,
        margin: const EdgeInsets.all(12.0),
        color: AppColors.primaryLight,
        child: widget.review.user.imageUrl != null
            ? AdaptiveImage(widget.review.user.imageUrl)
            : Center(
                child: Text(
                  widget.review.user.name[0],
                  style: AppTextStyles.large.withColor(AppColors.primaryDark),
                ),
              ),
      ),
    );
  }
}
