import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/common/user_avatar_square.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        padding: const EdgeInsets.only(
            top: 4.0, left: 8.0, right: 8.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                UserAvatarSquare(
                  username: review.user.name,
                  imageUrl: review.user.imageUrl,
                ),
                _buildTitle(context),
                const Spacer(),
                _buildRating(context),
              ],
            ),
            _ReviewText(text: review.text),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            review.user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.t.headline5?.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        StarRatingBar(
          size: 15.0,
          rating: review.rating,
        ),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          review.rating.toStringAsFixed(1),
          style: AppTextStyles.headline4.bold.withColor(AppColors.darkFaded),
        ),
        const SizedBox(height: 4.0),
        Text(
          review.date,
          style: context.t.headline6,
        ),
        const SizedBox(height: 6.0),
      ],
    );
  }
}

class _ReviewText extends StatefulWidget {
  final String text;

  const _ReviewText({
    required this.text,
  }) : assert(text != null);

  @override
  _ReviewTextState createState() => _ReviewTextState();
}

class _ReviewTextState extends State<_ReviewText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => isExpanded = !isExpanded);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          widget.text,
          style: context.t.headline5,
          overflow: TextOverflow.ellipsis,
          maxLines: isExpanded ? 100 : 2,
        ),
      ),
    );
  }
}
