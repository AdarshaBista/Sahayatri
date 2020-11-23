import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/common/user_avatar_small.dart';

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
          padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  UserAvatarSmall(
                    username: widget.review.user.name,
                    imageUrl: widget.review.user.imageUrl,
                  ),
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
            style: context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        StarRatingBar(
          size: 15.0,
          rating: widget.review.rating,
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
          style: AppTextStyles.headline4.bold.withColor(AppColors.darkFaded),
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.review.date,
          style: context.t.headline6,
        ),
        const SizedBox(height: 6.0),
      ],
    );
  }

  Widget _buildText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        widget.review.text,
        style: context.t.headline5,
        overflow: TextOverflow.ellipsis,
        maxLines: isExpanded ? 100 : 2,
      ),
    );
  }
}
